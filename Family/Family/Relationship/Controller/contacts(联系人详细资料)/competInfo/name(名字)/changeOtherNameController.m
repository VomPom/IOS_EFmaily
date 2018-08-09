//
//  NameController.m
//  Family
//
//  Created by Julis on 16/7/1.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "changeOtherNameController.h"

#define WidthW [UIScreen mainScreen].bounds.size.width
@interface changeOtherNameController ()<UITextFieldDelegate>

@end

@implementation changeOtherNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏“完成按钮”（并没有将值带回来）
    [self Navigation];
    [self UItextview];
    self.view.backgroundColor= HCColor(244, 244, 244);
   }
-(void)UItextview
{

    _textField=[[UITextField alloc]initWithFrame: CGRectMake(10, 15, WidthW-10, 50)];
    self.textField.delegate=self;
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.placeholder=@"请输入用户名";
    _textField.text=_name;
    _textField.font = [UIFont systemFontOfSize:17.0];
    _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, 10, 50)];
    blankView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:blankView];
    [self.view addSubview:_textField];
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
   [_textField resignFirstResponder];
}
//对字数限制


-(void)Navigation
{
    
        
    [self.navigationItem setTitle:@"用户名"];
    _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(backAndSendMessage)];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName]=[UIColor colorWithRed:49/255.0 green:194/255.0 blue:125/255.0 alpha:1];
    [_rightItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=_rightItem;
    
}
-(void)backAndSendMessage
{
//    IndexMineViewController *IndexMineVc = [[IndexMineViewController alloc]init];
//    IndexMineVc.name=_textField.text;
//    NSLog(@"%@",IndexMineVc.name);
//    MineFirst *MineFirstVc = [[MineFirst alloc]init];
//    MineFirstVc.name=_textField.text;
//    NSLog(@"%@",MineFirstVc.name);
    [self.navigationController popViewControllerAnimated:YES];
}

//监听值改变

-(void)textFieldDidChange :(UITextField *)theTextField{
    if([theTextField.text length]==0)
        self.rightItem.enabled=NO;
    else
        self.rightItem.enabled=YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.textField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 10) {
            return NO;
        }
    }
    
    return YES;
}

@end
