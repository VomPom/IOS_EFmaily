//
//  login_signup.m
//  Family
//
//  Created by mac  on 16/7/10.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "login_signup.h"
#import "login_signupnext.h"
@interface login_signup ()

@end

@implementation login_signup

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
     [self.navigationItem setTitle: @"注册" ];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.signup_phone resignFirstResponder];
}

- (IBAction)signup_nextbtn {
    login_signupnext *vc = [[login_signupnext alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end

