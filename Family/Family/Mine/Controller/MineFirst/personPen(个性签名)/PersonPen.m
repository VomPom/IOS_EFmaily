//
//  PersonPen.m
//  Family
//
//  Created by Julis on 16/7/1.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "PersonPen.h"
#define HeightH [UIScreen mainScreen].bounds.size.height
#define WidthW [UIScreen mainScreen].bounds.size.width
@interface PersonPen ()<UITextViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,assign) int alphaNumber;
@property (nonatomic,strong) UIBarButtonItem *rightItem;
@property (nonatomic,strong) UILabel *alphaNumberLabel;
@end

@implementation PersonPen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Navigation];
    //导航栏“完成按钮”（并没有将值带回来）
    [self UItextview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)UItextview
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.textView.scrollEnabled = NO;
    self.view.backgroundColor=HCColor(240, 240, 240);
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0,84, WidthW, 100)];
    self.textView.delegate=self;
    self.textView.backgroundColor=[UIColor whiteColor];
   // [self.textView setContentInset:UIEdgeInsetsMake(10, 10, 0, 0)];
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.font = [UIFont systemFontOfSize:20.0f];
    //设置字数按钮
    _alphaNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthW-40, 160, 40, 20)];
    self.textView.text=_personpenStr;
    [self.view addSubview:_textView];
    [self.view addSubview:_alphaNumberLabel];
   // [self.view addSubview:clearButton];
    
    
    
}

-(void)Navigation
{
    [self.navigationItem setTitle:@"个性签名"];
    _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName]=[UIColor colorWithRed:49/255.0 green:194/255.0 blue:125/255.0 alpha:1];
    [_rightItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=_rightItem;
    
}
-(void)back
{
     [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _alphaNumber=50-(int)[_textView.text length];
    _alphaNumberLabel.text=[NSString stringWithFormat:@"%d",_alphaNumber];

    
}
- (void)textViewDidChange:(UITextView *)textView;
{
    _alphaNumber=50-(int)[textView.text length];
    NSLog(@"%d",_alphaNumber);
    if([textView.text length]==0||_alphaNumber<0)
    {
        self.rightItem.enabled=NO;
        _alphaNumberLabel.textColor=[UIColor redColor];

    }
    else
    {
        self.rightItem.enabled=YES;
        _alphaNumberLabel.textColor=[UIColor lightGrayColor];
    }
    _alphaNumberLabel.text=[NSString stringWithFormat:@"%d",_alphaNumber];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=60)
    {
        return  NO;
    }
    else
    {
        return YES;
    }
}


@end
