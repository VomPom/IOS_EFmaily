//
//  BaseCell.h
//  MYTableViewCellClick
//
//  Created by Magic Yu on 16/6/17.
//  Copyright © 2016年 MagicYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@end
