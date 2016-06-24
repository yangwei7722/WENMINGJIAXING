//
//  NewsDetail.h
//  文明嘉兴
//
//  Created by yangwei on 16/6/23.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetail : NSObject

@property(assign,nonatomic)NSNumber*newsId;
@property(copy,nonatomic)NSString*title;
@property(copy,nonatomic)NSString*summary;
@property(copy,nonatomic)NSString*source;

@property(copy,nonatomic)NSString*issuestime;
@property(strong,nonatomic)NSString*content;
@property(strong,nonatomic)NSString*link;

@property(strong,nonatomic)NSString*categoryFk;

@property (nonatomic,strong) AFHTTPSessionManager * manager;
@property(strong,nonatomic)NSDictionary*detailDict;
@property(strong,nonatomic)NSMutableSet*mutableSet;

+(void)getDataWithDict:(NSDictionary*)parameter;

-(void)getDataWithDict:(NSDictionary*)parameter;

@end
