//
//  AlbumTableViewCell.h
//  Family
//
//  Created by Julis on 16/7/13.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageVeiw;
@property (weak, nonatomic) IBOutlet UITextView *describView;
@property (weak, nonatomic) IBOutlet UILabel *pictureNumLabel;

@end
