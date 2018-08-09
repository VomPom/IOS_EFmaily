//
//  FZHTableViewCell.h
//  FZHTableViewCellSelectState
//
//  Created by 冯志浩 on 16/6/12.
//  Copyright © 2016年 FZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZHTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIButton *btn_checked;
@property(nonatomic, assign) BOOL is_selected;

- (void)show_select;

- (void)hide_select;
@end
