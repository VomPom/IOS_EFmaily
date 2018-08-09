//
//  clickRealtiveConnectViewController.m
//  Family
//
//  Created by Julis on 16/7/19.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "clickRealtiveConnectViewController.h"
#import "manageTableViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface clickRealtiveConnectViewController ()
{
    UIScrollView *scrollview;
}
@end

@implementation clickRealtiveConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -64, WIDTH, HEIGHT*3)];
    self.view.backgroundColor = [UIColor colorWithRed:0.9176 green:0.9176 blue:0.9451 alpha:1.0];
    
    [self setBgView];
    scrollview.contentSize = CGSizeMake(WIDTH,HEIGHT*3);
    [self inviteOfMenmeberView];
    [self mangeRalativeCircle];
    [self.view addSubview:scrollview];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setBgView
{
    NSString *relatvieAndFriendName = @"落叶";
    int personNum = 10;
    int pictureNum = 35;
        UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/2)];
    
    //背景图片
    bgView.image = [UIImage imageNamed:@"ablumBG"];
    
    //头像
    UIImageView *iconHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-35, WIDTH/6, 70, 70)];
    iconHeadView.image = [UIImage imageNamed:@"icon_person"];
    
    UILabel *describe = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(iconHeadView.frame)+10, WIDTH, 70)];
    describe.text = [NSString stringWithFormat:@"%@的亲友圈",relatvieAndFriendName];
    describe.textAlignment = NSTextAlignmentCenter;
    describe.textColor = [UIColor whiteColor];
    describe.font = [UIFont systemFontOfSize:16.0f];
    
    UILabel *numOfPersonAndPicture = [[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH/4+25+55, WIDTH, 70)];
    numOfPersonAndPicture.text = [NSString stringWithFormat:@"%d个成员、%d张照片",personNum,pictureNum];
    numOfPersonAndPicture.textAlignment = NSTextAlignmentCenter;
    numOfPersonAndPicture.textColor = [UIColor whiteColor];
    numOfPersonAndPicture.font = [UIFont systemFontOfSize:12.0f];
    //布局背景以上栏
    [bgView addSubview:numOfPersonAndPicture];
    [bgView addSubview:describe];
    [bgView addSubview:iconHeadView];
    
    
    UIView *fammilyofView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame), WIDTH, 50)];
    fammilyofView.backgroundColor = [UIColor colorWithRed:0.3961 green:0.7216 blue:0.2039 alpha:1.0];
    UIImageView *familyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-75, 0, 150, 50)];
    familyImageView.image = [UIImage imageNamed:@"famaliy"];
    [fammilyofView addSubview:familyImageView];
    [scrollview addSubview:fammilyofView];
    [scrollview addSubview:bgView];
}

-(void)inviteOfMenmeberView
{
    int index=5;
    UIView *inviteView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT/3+50, WIDTH, 110)];
    inviteView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    
    for(int i=0;i<index;i++)
    {
        UIView *view = [self cellOfimformation];
        view.frame = CGRectMake(10+i*60, 10, view.frame.size.width, view.frame.size.height);
        [inviteView addSubview:view];
    }
    
    
    
    UIButton *weChatInviteBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 110-35, WIDTH/2-30, 30)];
    weChatInviteBtn.backgroundColor = [UIColor colorWithRed:0.1765 green:0.7255 blue:0.4157 alpha:1.0];
    weChatInviteBtn.layer.cornerRadius=3;
    weChatInviteBtn.clipsToBounds=YES;
    [weChatInviteBtn setTitle:@"微信邀请" forState:UIControlStateNormal];
    [weChatInviteBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [weChatInviteBtn setImage:[UIImage imageNamed:@"icon_wechat2"] forState:UIControlStateNormal];
     [weChatInviteBtn setImage:[UIImage imageNamed:@"icon_wechat2"] forState:UIControlStateHighlighted];
    
    [weChatInviteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [weChatInviteBtn addTarget:self action:@selector(bc) forControlEvents:UIControlEventTouchUpInside];
    
    
     UIButton *phoneListInvieteBtn = [[UIButton alloc]initWithFrame:CGRectMake(20+WIDTH/2-30+20, 110-35, WIDTH/2-30, 30)];
    phoneListInvieteBtn.backgroundColor = [UIColor colorWithRed:0.1765 green:0.7255 blue:0.4157 alpha:1.0];
    phoneListInvieteBtn.layer.cornerRadius=3;
    phoneListInvieteBtn.clipsToBounds=YES;
    [phoneListInvieteBtn setTitle:@"通讯录邀请" forState:UIControlStateNormal];
    [phoneListInvieteBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];

    
    
    [phoneListInvieteBtn setImage:[UIImage imageNamed:@"icon_wechat2"] forState:UIControlStateNormal];
    [phoneListInvieteBtn setImage:[UIImage imageNamed:@"icon_wechat2"] forState:UIControlStateHighlighted];
    
    [phoneListInvieteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [inviteView addSubview:phoneListInvieteBtn];
    [inviteView addSubview:weChatInviteBtn];
    [scrollview addSubview:inviteView];
}
-(void)bc
{
    NSLog(@"g");
}
-(UIView *)cellOfimformation
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 55)];

    UIImageView *iconHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 40, 40)];
   
    iconHeadView.image = [UIImage imageNamed:@"icon_person"];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 50, 20)];
    nameLabel.text = @"落叶";
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:10.0f];
    [view addSubview:nameLabel];
    [view addSubview:iconHeadView];
    return  view;
}
-(void)mangeRalativeCircle
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT/3+160+10, WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    iconView.image = [UIImage imageNamed:@"icon_seting"];
    
    UILabel *mangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, WIDTH-50, 30)];
    mangeLabel.text = @"管理亲友圈";
    mangeLabel.font = [UIFont systemFontOfSize:14.0f];
    
    UILabel *describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 25, WIDTH-60, 20)];
    describeLabel.text =@"修改资料，管理成员";
    describeLabel.textColor = [UIColor grayColor];
    describeLabel.font = [UIFont systemFontOfSize:11.0f];
    [view addSubview:mangeLabel];
    [view addSubview:describeLabel];
    [view addSubview:iconView];
    [scrollview addSubview:view];
    
    //添加view动作
    UITapGestureRecognizer *tagp  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToManagePage)];
    [view addGestureRecognizer:tagp];
}
-(void)pushToManagePage
{
    manageTableViewController *vc = [[manageTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
