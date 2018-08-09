//
//  FZHTableViewCell.m
//  FZHTableViewCellSelectState
//
//  Created by 冯志浩 on 16/6/12.
//  Copyright © 2016年 FZH. All rights reserved.
//

#import "FZHTableViewCell.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation FZHTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return  self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.frame = CGRectMake(15, 0, 50, 50);
    [self addSubview:self.nameLabel];
    
    self.btn_checked = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_checked setBackgroundImage:[UIImage imageNamed:@"btn_checked"] forState:UIControlStateNormal];
    
    self.btn_checked.frame = CGRectMake(SCREEN_WIDTH - 35, (self.bounds.size.height-25)/2+5, 25, 25);
    [self addSubview:self.btn_checked];
    if(self.is_selected == NO){
        [self.btn_checked setHidden:YES];
    }
}

- (void)show_select{
    
    if (self.is_selected == NO) {
        [self.btn_checked setHidden:NO];
        [self bringSubviewToFront:self.btn_checked];
        self.is_selected = YES;
    }else{
        NSLog(@"self.is_selected == YES");
        [self hide_select];
    }
}

- (void)hide_select{
    [self.btn_checked setHidden:YES];
    self.is_selected = NO;
}


@end
