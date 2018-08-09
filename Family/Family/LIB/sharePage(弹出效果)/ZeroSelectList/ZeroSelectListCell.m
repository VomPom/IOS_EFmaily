//
//  SelectListCell.m
//  SelectList
//
//  Created by ZWX on 16/6/15.
//  Copyright © 2016年 ZWX. All rights reserved.
//

#import "ZeroSelectListCell.h"

@implementation ZeroSelectListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    self.imageView.frame = CGRectMake(15,10,20,20);
    
    CGRect tmpFrame     = self.textLabel.frame;
    tmpFrame.origin.x   = 45;
    tmpFrame.size.width = 80;
    
    self.textLabel.frame = tmpFrame;
    
}

@end
