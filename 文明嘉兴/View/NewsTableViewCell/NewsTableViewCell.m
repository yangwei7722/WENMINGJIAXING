//
//  NewsTableViewCell.m
//  文明嘉兴
//
//  Created by yangwei on 16/6/4.
//  Copyright © 2016年 yangwei. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];


    if (self) {
        self=[[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:self options:nil ]lastObject];
    }



    return self;



}










- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
