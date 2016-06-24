//
//  NewsViewController.m
//  文明嘉兴
//
//  Created by yangwei on 16/6/15.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import "NewsViewController.h"



@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{

    NSInteger pageNum;
    
    NSDictionary*dict;
  
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)SDCycleScrollView*sdCycleScrollView;  //滚动视图
@property(strong,nonatomic)NSMutableArray<News*>*newsArray;
@property(strong,nonatomic)UIRefreshControl*refresh;            //上下拉刷新
@property(strong,nonatomic)NSArray*bannerArray;
@property(strong,nonatomic)AFHTTPSessionManager*manager;        //网络请求


@end

@implementation NewsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    _tableView.delegate=self;
    _tableView.dataSource=self;

    
    //注册tableViewCell
    [_tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _tableView.showsVerticalScrollIndicator=NO;
   
      //添加通知当取得数据就进行通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNewsByNotification:) name:GetNewsDataNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handeleBannerByNotification:) name:GetBannerDataNotification object:nil];
    

    
    //下拉刷新
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageNum=1;
        
        [Banner getBannerData];
        
        [News getDataWithPageNum:pageNum];
        
    }];
    
    
    
    //上拉刷新
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        //每向上拖一次让页码加一次
        
        [News getDataWithPageNum:++pageNum];
        
        
    }];
    //默认请求数据并刷新
    [self.tableView.mj_header beginRefreshing];
//    [self.tableView.mj_footer beginRefreshing];
    
    //先让tableView去刷新数据
//    [News getDataWithPageNum:pageNum];
//    [self.tableView.mj_header beginRefreshing];
  //  [self.tableView reloadData];
   
}



//tableView通知的回调方法
-(void)handleNewsByNotification:(NSNotification*)notification{
    
    
    //判断是否第一页
    if (pageNum == 1) {
        self.newsArray = [NSMutableArray array];
    }
    //判断这个object是不是数组
    if ([notification.object isKindOfClass:[NSArray class]]) {
        //往数组中追加，这个一般用户上拉时会调用
        [self.newsArray addObjectsFromArray:notification.object];
    }
    [self.tableView reloadData];//刷新表格上面的数据
    
    //停止加载数据状态
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    
    
    
    
    
}

//banner通知的回调方法
-(void)handeleBannerByNotification:(NSNotification*)notification{
    
    self.bannerArray=notification.object;
    
    //   NSLog(@"%@",self.bannerArray);
    NSMutableArray*imageArray=[NSMutableArray array];
    NSMutableArray*titleArray=[NSMutableArray array];
    for (int i=0; i<5; i++) {
        News*news=self.bannerArray[i];
        [imageArray addObject:news.image];
        [titleArray addObject:news.title];
        
        
    }
    
    _sdCycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 375, 255) delegate:self placeholderImage:[UIImage imageNamed:@"loadFalied.png"]];
    
    _tableView.tableHeaderView=_sdCycleScrollView;
    
    //设置轮播图片和文字
    _sdCycleScrollView.imageURLStringsGroup=imageArray;
    _sdCycleScrollView.titlesGroup=titleArray;
    
    _sdCycleScrollView.titleLabelHeight=55;
    
    
    //上下滑动
    _sdCycleScrollView.scrollDirection=NO;
    
    //pagecontrol设为右对齐
    _sdCycleScrollView.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
    
    //轮播时间间隔
    _sdCycleScrollView.autoScrollTimeInterval=3;
    
    //           [self.tableView addSubview:_sdCycleScrollView];
    
}



//移除观察者
-(void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GetDetailNewsNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    
}


//设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //   NSLog(@"1234");
    
    //刷新tableView被多次调用
    //    NSLog(@"%ld",self.newsArray.count);
    
    return self.newsArray.count;
    
}

//绘制cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //取数据
    //    NSDictionary*dict=self.newsArray[indexPath.row];
    
    News*news=self.newsArray[indexPath.row];
    
    [cell.newsImageView setImageWithURL:[NSURL URLWithString:news.image] placeholderImage:[UIImage imageNamed:@"loadFalied.png"]];
    
    
    cell.newsMessage.text=news.title;
    
    cell.dateTime.text=news.issuestime;
    cell.praise.text=[@"评论:" stringByAppendingFormat:@"%@",news.praiseNum];
    cell.commit.text=[@"赞:" stringByAppendingFormat:@"%@%ld",news.browseNum,indexPath.row];
    
    
    return cell;
}

//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 85;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    News*news=self.newsArray[indexPath.row];
    

//这里注意单词错误将会导后面的网络请求失败
                 dict= @{
                           @"newsId":news.newsId,
                           @"categoryFk":@1,
                           @"pageNum":@(indexPath.row)
                           
                           };
        //跳转传值
     [self performSegueWithIdentifier:@"detail" sender:self];
}


//线传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    if ([segue.identifier isEqualToString:@"detail"]) {
        
        id send=segue.destinationViewController;
        
        [send setValue:dict forKey:@"parameter"];
    }
  
    


}






-(AFHTTPSessionManager*)manager{
    
    if (_manager) {
        return _manager;
    }
    
    _manager=[AFHTTPSessionManager manager];
    
    _manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    return _manager;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
