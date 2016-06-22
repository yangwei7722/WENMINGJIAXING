//
//  banner.h
//  文明嘉兴
//
//  Created by yangwei on 16/6/14.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject
@property(copy,nonatomic)NSString*image;
@property(copy,nonatomic)NSString*title;

@property (nonatomic,strong) AFHTTPSessionManager * manager;

+(void)getBannerData;
-(void)getBannerData;
@end
