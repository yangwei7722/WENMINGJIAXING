//
//  News.m
//  文明嘉兴
//
//  Created by yangwei on 16/6/8.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import "News.h"

@implementation News


+(void)getDataWithPageNum:(int)pageNum{
    
    
    [[[self class]alloc]getDataWithPageNum:pageNum];
    
    
}



-(void)getDataWithPageNum:(int)pageNum{
   
   
    NSDictionary*dict=@{
                        
                        @"categoryId":@1,
                        @"pageNum":@(pageNum)
                        
                        };
    
    //请求时使用JSON数据序列化
    
 
    
    //post请求
    [self.manager POST:[HTTP_HOST stringByAppendingString:HTTP_NEWS] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            
            
            NSArray*tempArray=responseObject[@"data"];
            
            [News mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"title":@"title",
                         @"image":@"image",
                         @"praiseNum":@"praiseNum",
                          @"browseNum":@"browseNum",
                         
                         };
            }];
            
            NSArray*resultArray=[News mj_objectArrayWithKeyValuesArray:tempArray];
        //发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:GetNewsDataNotification object:resultArray];
            
                }
        
        else{
            
            
            NSLog(@"出错了。。。%@",responseObject[@"message"]);//否则就打印出服务器的结果状态说明
            
            
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
    
    _manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    
    return _manager;
    
}




@end
