//
//  ViewController.m
//  文明嘉兴
//
//  Created by yangwei on 16/6/4.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import "ViewController.h"
#import "NewsViewController.h"
#import "MaralsModelViewController.h"

#import "YcSegmentView.h"



@interface ViewController ()<YcSegmentViewDelegate>


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  
    
    NSArray*titleArray=@[@"文明播报",@"道德模范",@"文明创建",@"志愿服务",@"未成年人",@"区县传真"];
   
    
    NSArray*viewControllerArray=@[@"NewsViewController",@"NewsViewController",@"NewsViewController",@"NewsViewController",@"NewsViewController",@"NewsViewController"];
    
    
    YcSegmentView*segmentView=[[YcSegmentView alloc]initWithFrame:CGRectMake(0, 20, SCREENW, SCREENH) andHeaderHeight:30 andTitleArray:titleArray andShowControllerNameArray:viewControllerArray];
    
    segmentView.delegate=self;
    
    [self.view addSubview:segmentView];
    
    
   

}

-(void)didSelectIndex:(NSInteger)index{

 NSLog(@"%ld",index);
    
       
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
