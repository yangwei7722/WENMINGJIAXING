//
//  ViewController.m
//  文明嘉兴
//
//  Created by yangwei on 16/6/4.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import "ViewController.h"
#import "NewsViewController.h"
#import "YSLContainerViewController.h"


@interface ViewController ()<YSLContainerViewControllerDelegate>

@property(strong,nonatomic)NSMutableArray*viewContreollerArray;
@property(strong,nonatomic)NSMutableArray*titleArray;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    [self.titleArray addObjectsFromArray:@[@"文明播报",@"道德模范",@"文明创建",@"志愿服务",@"未成年人",@"区县传真",@"主题活动",@"我们的节日"]];
 
//    NSArray*viewControllerArray=@[@"NewsViewController"];
//    
//    
//    YcSegmentView*segmentView=[[YcSegmentView alloc]initWithFrame:CGRectMake(0, 20, SCREENW, SCREENH) andHeaderHeight:30 andTitleArray:titleArray andShowControllerNameArray:viewControllerArray];
//    
//    segmentView.delegate=self;
//    
//    [self.view addSubview:segmentView];
    
 //制作上面八个控制器
    
    for (int i=0; i<8; i++) {
        NewsViewController*newsViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
        
        newsViewController.title=self.titleArray[i];
        
        [self.viewContreollerArray addObject:newsViewController];
        
    }
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    YSLContainerViewController*containerVC=[[YSLContainerViewController alloc]initWithControllers:self.viewContreollerArray topBarHeight:statusHeight parentViewController:self];
    
    containerVC.delegate=self;
    
    containerVC.menuItemTitleColor=[UIColor blackColor];
    containerVC.menuItemSelectedTitleColor=[UIColor redColor];
    
    
    [self.view addSubview:containerVC.view];

}

-(void)containerViewItemIndex:(NSInteger)index currentController:(NewsViewController *)controller{


    [controller viewWillAppear:YES];

    [controller setCategoryId:(NSInteger)index+1];

}



//懒加载
-(NSMutableArray*)viewContreollerArray{

    if (!_viewContreollerArray) {
        _viewContreollerArray=[NSMutableArray array];
    }

    return _viewContreollerArray;


}

-(NSMutableArray*)titleArray{
    if (!_titleArray) {
        _titleArray=[NSMutableArray array];
    }

    return _titleArray;

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
