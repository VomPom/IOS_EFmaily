//
//  MessageMineCell.h
//  Family
//
//  Created by ZHC on 16/7/8.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageMineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;


+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
