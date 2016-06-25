//
//  DetailNewsViewController.m
//  文明嘉兴
//
//  Created by yangwei on 16/6/22.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import "DetailNewsViewController.h"


@interface DetailNewsViewController ()<UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *bannerLable;

@property (weak, nonatomic) IBOutlet UILabel *deatalTime;

@property (weak, nonatomic) IBOutlet UILabel *sourceDetail;


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(strong,nonatomic)AFHTTPSessionManager*manager;

@property(strong,nonatomic)UIView*lgView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;




@end

@implementation DetailNewsViewController


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //拦截网页中的图片  并修改图片大小
    [self.webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=450;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = 300;"
     "myimg.height = 200;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    //执行一段JavaScript代码
    [self.webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //获取HTML内容的高度
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    CGRect frame = webView.frame;
    frame.size.height = height+10;
    
    self.webView.frame = frame;
    
    //修改托线约束，因为高度不固定，故托线后进行修改
    self.webViewHeight.constant = frame.origin.y+height+10;
    
    //设置滚动视图的ContentSize
    self.scrollView.contentSize = CGSizeMake(320, frame.origin.y+height+10);
    
    
    [self.view layoutIfNeeded];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    NSLog(@"----%@",_parameter);
    
    
    
    [self registeredNSNotificationCenter];
  
    
    
}

-(void)registeredNSNotificationCenter{
    
   self.webView.delegate =self;
    
    self.webView.userInteractionEnabled = NO;

//发送通知去请求数据
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNewsByNotification:) name:GetDetailNewsNotification object:nil];
 [NewsDetail getDataWithDict:self.parameter];

}


//通知中心的回调方法并刷新数据
-(void)handleNewsByNotification:(NSNotification*)notification{


    NewsDetail*news=notification.object;
    
    self.bannerLable.text=news.title;
    
    self.deatalTime.text=[@"发布日期:"stringByAppendingFormat:@"%@",news.issuestime];
    self.sourceDetail.text=[@"来源:"stringByAppendingFormat:@"%@",news.source];
    
    [self.webView loadHTMLString:news.content baseURL:nil];




}


//移除通知中心
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:GetNewsDataNotification object:nil];

    [[NSNotificationCenter defaultCenter]removeObserver:self];



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//返回到新闻页面
- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
