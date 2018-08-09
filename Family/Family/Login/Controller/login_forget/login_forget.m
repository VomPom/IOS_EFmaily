//
//  login_forget.m
//  Family
//
//  Created by mac  on 16/7/10.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "login_forget.h"
#import "login_forgetnext.h"
@interface login_forget ()

@end

@implementation login_forget

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES ;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationItem setTitle: @"忘记密码" ];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.forget_phone resignFirstResponder];
}

- (IBAction)forgettonext {
    login_forgetnext *vc = [[login_forgetnext alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
