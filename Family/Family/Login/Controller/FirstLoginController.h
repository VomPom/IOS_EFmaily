//
//  FirstLoginController.h
//  Family
//
//  Created by ZHC on 16/7/8.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstLoginController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *login_signup;
@property (strong, nonatomic) IBOutlet UIButton *login_Forget;
@property (strong, nonatomic) IBOutlet UIButton *login_Login;
@property (weak, nonatomic) IBOutlet UITextField *loginpassward;
@property (weak, nonatomic) IBOutlet UITextField *loginID;



@end
