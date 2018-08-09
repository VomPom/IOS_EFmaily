//
//  MineTableViewCell.m
//  Family
//
//  Created by Julis on 16/7/9.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMineTableViewCellID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineTableViewCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

@end
