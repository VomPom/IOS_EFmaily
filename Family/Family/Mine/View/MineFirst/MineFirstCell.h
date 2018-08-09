//
//  MineFirstCell.h
//  Family
//
//  Created by Julis on 16/7/9.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineFirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phonenumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexIcon;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
