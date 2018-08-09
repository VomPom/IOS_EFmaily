//
//  MineTableViewCell.h
//  Family
//
//  Created by Julis on 16/7/9.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *IconView;
@property (weak, nonatomic) IBOutlet UILabel *tietleLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
