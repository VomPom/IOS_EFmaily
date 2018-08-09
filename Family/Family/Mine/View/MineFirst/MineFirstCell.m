//
//  MineFirstCell.m
//  Family
//
//  Created by Julis on 16/7/9.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "MineFirstCell.h"

@implementation MineFirstCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    MineFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineFirstCellID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineFirstCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

@end
