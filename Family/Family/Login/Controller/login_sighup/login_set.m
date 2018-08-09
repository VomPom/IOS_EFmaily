//
//  login_set.m
//  Family
//
//  Created by mac  on 16/7/12.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "login_set.h"

@interface login_set ()

@end

@implementation login_set

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.set_passward resignFirstResponder];
    [self.set_passwardagain resignFirstResponder];
}


@end
