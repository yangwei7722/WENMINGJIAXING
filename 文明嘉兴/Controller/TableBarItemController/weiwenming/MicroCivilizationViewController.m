//
//  MicroCivilizationViewController.m
//  文明嘉兴
//
//  Created by yangwei on 16/6/22.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import "MicroCivilizationViewController.h"



@interface MicroCivilizationViewController ()

@end

@implementation MicroCivilizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView*web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    
    [self.view addSubview:web];
    
    //网络请求
    
    NSURL*url=[NSURL URLWithString:@"http://weibo.com/u/2852517300?is_hot=1"];
    
    NSURLRequest*request=[NSURLRequest requestWithURL:url];
    
    [web  loadRequest:request];
    
    //加载效果
    
    MBProgressHUD*hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //显示文字
    hud.label.text=@"Loading...";
  
    //隐藏时间
    [hud hideAnimated:YES afterDelay:1];
    [self.view addSubview:hud];
    
    
    
    
    
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

@end
