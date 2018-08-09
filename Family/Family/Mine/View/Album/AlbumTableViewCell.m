//
//  AlbumTableViewCell.m
//  Family
//
//  Created by Julis on 16/7/13.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "AlbumTableViewCell.h"
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width
@implementation AlbumTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumTableViewCellID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AlbumTableViewCell" owner:self options:nil] lastObject];
    }
    
    return cell;
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
