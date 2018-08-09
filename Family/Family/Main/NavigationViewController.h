//
//  NavigationViewController.h
//  微享圈
//
//  Created by Mac on 15/12/3.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UINavigationController
typedef void (^back)();
@property (nonatomic, copy) back back;

@end
