//
//  ChangePassword.m
//  Family
//
//  Created by Julis on 16/7/10.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "ChangePassword.h"
#define WidthW [UIScreen mainScreen].bounds.size.width
@interface ChangePassword ()<UITextFieldDelegate>
{
    UITextField *OriginalPassword;
}
//@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,copy) NSString *defaultStr;
@property (nonatomic,strong) UIBarButtonItem *rightItem;
//@property (nonatomic,strong)  UITextField *OriginalPassword;
@end
@implementation ChangePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏“完成按钮”（并没有将值带回来）
    [self Navigation];
    [self OriginalPassword];
    [self NewPassword];
    [self ConfirmPassword];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)OriginalPassword
{
    OriginalPassword=[[UITextField alloc]initWithFrame: CGRectMake(100, 79, WidthW-100, 50)];
    OriginalPassword.backgroundColor=[UIColor whiteColor];
    OriginalPassword.placeholder=@"请输入原密码";
    OriginalPassword.clearButtonMode=UITextFieldViewModeWhileEditing;
    OriginalPassword.secureTextEntry = YES;

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 79, 100, 50)];
    title.text=@"   原密码";
    [OriginalPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    title.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:title];
    [self.view addSubview:OriginalPassword];
}

-(void)NewPassword
{
    UITextField *NewPassword=[[UITextField alloc]initWithFrame: CGRectMake(100, 130, WidthW-100, 50)];
    NewPassword.backgroundColor=[UIColor whiteColor];
    NewPassword.placeholder=@"请设置新密码";
    NewPassword.clearButtonMode=UITextFieldViewModeWhileEditing;
    NewPassword.secureTextEntry = YES;
  
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, 100, 50)];
    title.text=@"   新密码";
    [NewPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    title.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:title];
    [self.view addSubview:NewPassword];
    
}

-(void)ConfirmPassword
{
    UITextField *ConfirmPassword=[[UITextField alloc]initWithFrame: CGRectMake(100, 181, WidthW-100, 50)];
    ConfirmPassword.backgroundColor=[UIColor whiteColor];
    ConfirmPassword.placeholder=@"请再次输入";
    ConfirmPassword.clearButtonMode=UITextFieldViewModeWhileEditing;
    ConfirmPassword.secureTextEntry = YES;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 181, 100, 50)];
    title.text=@"   确认密码";
    title.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:title];
    [self.view addSubview:ConfirmPassword];
}

-(void)Navigation
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor=[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [self.navigationItem setTitle:@"密码修改"];
    _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName]=[UIColor colorWithRed:49/255.0 green:194/255.0 blue:125/255.0 alpha:1];
    [_rightItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=_rightItem;
    
    
}
//监听值改变

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"%@",theTextField.text);
    if([theTextField.text length]==0)
        self.rightItem.enabled=NO;
    else
        self.rightItem.enabled=YES;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [OriginalPassword resignFirstResponder];
}

@end
