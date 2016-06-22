//
//  banner.m
//  文明嘉兴
//
//  Created by yangwei on 16/6/14.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import "Banner.h"

@implementation Banner




+(void)getBannerData{
    
    [[[self class]alloc]getBannerData];
    
}
-(void)getBannerData{
    
    NSDictionary*dict=@{
                        
                        @"categoryId":@1
                        
                        };
    //请求时使用JSON数据序列化
    self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    [self.manager POST:[HTTP_HOST stringByAppendingString:HTTP_BANNER] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            
            NSArray*tempArray=responseObject[@"data"];
            
            [News mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         
                         @"image":@"imageurl",
                         @"title":@"title"
                         
                         
                         };
            }];
            
            NSArray*resultArray= [News mj_objectArrayWithKeyValuesArray:tempArray];
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:GetBannerDataNotification object:resultArray];
            
            
            
        }
        else{
            
            NSLog(@"头条Failed  %@",responseObject[@"message"]);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed   %@",error);
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
