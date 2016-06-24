//
//  NewsDetail.m
//  文明嘉兴
//
//  Created by yangwei on 16/6/23.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import "NewsDetail.h"


@implementation NewsDetail



+(void)getDataWithDict:(NSDictionary *)parameter{
    
    
    [[[self class]alloc]getDataWithDict:parameter];
    
    
}



-(void)getDataWithDict:(NSDictionary *)parameter{
    
//增加一个text/html支持
//    _mutableSet=[NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
//    [_mutableSet addObject:@"text/html"];
//    self.manager.responseSerializer.acceptableContentTypes=_mutableSet;
   
    
    //post请求
    [self.manager POST:HTTP_DETAIL_NEWS parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            
            NSLog(@"---------->");
            
            NSDictionary*data=responseObject[@"data"];
            
            NewsDetail*news=[NewsDetail mj_objectWithKeyValues:data];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:GetNewsDataNotification object:news];
            
        }
        
        else{
            
            
            NSLog(@"请求数据出错了。。。%@",responseObject[@"message"]);//否则就打印出服务器的结果状态说明
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了。。。%@",error);//错误提醒
    }];
    
    
    
}

-(AFHTTPSessionManager*)manager{
    
    if (_manager!=nil) {
        return _manager;
    }
    
    _manager=[AFHTTPSessionManager manager];
 //请求时使用JSON数据序列化
    _manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    
    return _manager;
    
}
@end
