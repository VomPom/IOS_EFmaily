//
//  IndexRelationshipCell.m
//  Family
//
//  Created by Julis on 16/7/15.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "IndexRelationshipCell.h"

@implementation IndexRelationshipCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    IndexRelationshipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexRelationshipCellID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IndexRelationshipCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

@end
