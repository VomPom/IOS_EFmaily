//
//  login_reset.m
//  Family
//
//  Created by mac  on 16/7/12.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "login_reset.h"

@interface login_reset ()

@end

@implementation login_reset

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
    [self.reset_passward resignFirstResponder];
    [self.reset_passwardagain resignFirstResponder];
}


@end
