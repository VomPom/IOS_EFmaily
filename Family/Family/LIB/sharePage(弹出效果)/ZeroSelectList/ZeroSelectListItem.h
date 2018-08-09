//
//  SelectListItem.h
//  SelectList
//
//  Created by ZWX on 16/6/15.
//  Copyright © 2016年 ZWX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZeroSelectListItem : NSObject

@property (nonatomic, strong) UIImage  * iconImage;

- (instancetype)initWithIconImage:(UIImage *)iconImage;
@end
