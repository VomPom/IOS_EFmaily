//
//  MessageMineCell.m
//  Family
//
//  Created by ZHC on 16/7/8.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "MessageMineCell.h"

@implementation MessageMineCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    MessageMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageMineCellID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageMineCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}


@end
