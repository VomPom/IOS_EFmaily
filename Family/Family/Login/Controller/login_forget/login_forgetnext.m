//
//  login_forgetnext.m
//  Family
//
//  Created by mac  on 16/7/19.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "login_forgetnext.h"
#import "login_reset.h"
@interface login_forgetnext ()
@property (nonatomic,strong) UIButton *receiveCheckNumButton;

@end

@implementation login_forgetnext

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES ;
    self.tabBarController.tabBar.hidden = YES;
        self.navigationController.navigationBar.hidden = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
  
  
    [self.navigationItem setTitle: @"注册" ];
   
    
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view

    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    _receiveCheckNumButton = [[UIButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2,164, 100, 40 )];
    _receiveCheckNumButton.backgroundColor = [UIColor purpleColor];
    [_receiveCheckNumButton setTitle:@"获取验证码"forState:UIControlStateNormal];
    [_receiveCheckNumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _receiveCheckNumButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _receiveCheckNumButton.layer.cornerRadius =5;
    _receiveCheckNumButton.layer.masksToBounds =YES;
    _receiveCheckNumButton.alpha =0.3;
    [_receiveCheckNumButton addTarget:self action:@selector(receiveCheckNumButton)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_receiveCheckNumButton];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.forgetnext_num resignFirstResponder];
}



//获取验证码倒计时

- (UIButton *)receiveCheckNumButton{
    
    __block int timeout=60;//倒计时时间
    
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){//倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示根据自己需求设置
                
                [_receiveCheckNumButton setTitle:@"重新获取"forState:UIControlStateNormal];
                
                _receiveCheckNumButton.userInteractionEnabled =YES;
                
                _receiveCheckNumButton.backgroundColor = [UIColor purpleColor];
                
            });
            
        }else{
            
            int seconds = timeout;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //让按钮变为不可点击的灰色
                
                _receiveCheckNumButton.backgroundColor = [UIColor grayColor];
                
                _receiveCheckNumButton.userInteractionEnabled =NO;
                
                //设置界面的按钮显示根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [_receiveCheckNumButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime]forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    return 0;
}

- (IBAction)nexttoreset {
    login_reset *vc = [[login_reset alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end