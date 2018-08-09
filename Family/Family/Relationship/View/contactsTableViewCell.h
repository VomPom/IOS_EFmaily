//
//  contactsTableViewCell.h
//  Family
//
//  Created by Julis on 16/7/15.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contactsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *phonenumber;
@property (weak, nonatomic) IBOutlet UILabel *invitePerson;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *iconinvitePerson;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
