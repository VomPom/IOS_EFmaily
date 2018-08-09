//
//  contactsTableViewCell.m
//  Family
//
//  Created by Julis on 16/7/15.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "contactsTableViewCell.h"

@implementation contactsTableViewCell

- (IBAction)inviteBtn {
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    contactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactsTableViewCellID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"contactsTableViewCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

@end
