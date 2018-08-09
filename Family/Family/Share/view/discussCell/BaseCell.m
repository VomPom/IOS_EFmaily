//
//  BaseCell.m
//  MYTableViewCellClick
//
//  Created by Magic Yu on 16/6/17.
//  Copyright © 2016年 MagicYu. All rights reserved.
//

#import "BaseCell.h"

@interface BaseCell ()


@end

@implementation BaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    NSArray *sentences = @[
                           
                           @"哈哈哈哈哈哈哈哈哈哈哈sdgasd哈哈哈哈哈哈!",
                           @"嘿嘿嘿嘿嘿嘿嘿嘿嘿",
                           @"吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼嗯嗯框架3卡拉胶快乐2🏡开了家快乐加5l",
                           @"呵呵呵呵sasadgsdklgjkljklqjtwkljeklwqjtklejwklgjaklsdjgkl呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵",
                           @"嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎asdgasdlgjkalsdjgkl;asdg嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎"
                           
                           ];
    
    self.describeLabel.text =sentences[arc4random_uniform(5)];

    
}


@end
