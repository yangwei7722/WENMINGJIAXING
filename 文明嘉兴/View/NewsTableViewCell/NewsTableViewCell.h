//
//  NewsTableViewCell.h
//  文明嘉兴
//
//  Created by yangwei on 16/6/4.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@property (weak, nonatomic) IBOutlet UILabel *newsMessage;

@property (weak, nonatomic) IBOutlet UILabel *dateTime;

@property (weak, nonatomic) IBOutlet UILabel *praise;

@property (weak, nonatomic) IBOutlet UILabel *commit;


@end
