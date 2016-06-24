//
//  News.h
//  文明嘉兴
//
//  Created by yangwei on 16/6/8.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "AFHTTPSessionManager.h"

@interface News : NSObject

@property(assign,nonatomic)NSNumber*newsId;
@property(copy,nonatomic)NSString*title;
@property(copy,nonatomic)NSString*summary;
@property(copy,nonatomic)NSString*source;
@property(copy,nonatomic)NSString*image;
@property(assign,nonatomic)NSNumber*praiseNum;
@property(assign,nonatomic)NSNumber*browseNum;


@property(copy,nonatomic)NSString*issuestime;
@property(strong,nonatomic)NSString*content;
@property(strong,nonatomic)NSString*link;
@property(strong,nonatomic)NSString*updatetime;
@property(strong,nonatomic)NSString*categoryFK;

@property (nonatomic,strong) AFHTTPSessionManager * manager;



+(void)getDataWithPageNum:(NSInteger)pageNum;

-(void)getDataWithPageNum:(NSInteger)pageNum;



@end
