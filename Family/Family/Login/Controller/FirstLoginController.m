//
//  FirstLoginController.m
//  Family
//
//  Created by ZHC on 16/7/8.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "FirstLoginController.h"
#import "login_signup.h"
#import "login_forget.h"

@interface FirstLoginController ()<UITextFieldDelegate>



@end



@implementation FirstLoginController


- (IBAction)FirstToForget {
    login_forget *vc = [[login_forget alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)FirstToSignup {
    login_signup *vc = [[login_signup alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    [super viewDidLoad];
    self.login_Login.layer.cornerRadius = 6;
    self.login_Login.layer.masksToBounds = YES;
    self.loginID.delegate = self;
    self.loginpassward.delegate = self;
    
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 150; // tweak as needed
    const float movementDuration = 0.2f; // tweak as needed
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.loginpassward resignFirstResponder];
    [self.loginID resignFirstResponder];
}



@end
