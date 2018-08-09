//
//  MessageMineController.m
//  Family
//
//  Created by ZHC on 16/7/8.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "MessageMineController.h"
#import "MessageMineCell.h"
@interface MessageMineController ()<UITableViewDelegate>
@property (nonatomic,retain,nonnull) UIBarButtonItem *rightItem;
@end
#define WIDTH [UIScreen mainScreen].bounds.size.width
@implementation MessageMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self NavigationSet];

}
-(void)NavigationSet
{
    //导航栏标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.text = @"我的消息";
    self.navigationItem.titleView = titleLabel;
    //右边标题
    _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"消息设置" style:UIBarButtonItemStyleDone target:self action:nil];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.1176 green:0.8078 blue:0.4 alpha:1.0];
    [_rightItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=_rightItem;
    
    // 1.去掉背景图片和底部线条
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0)
    return 4;
    else
        return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageMineCell *cell =  [MessageMineCell cellWithTableView:tableView];
    if(indexPath.section==0)
    {
    switch (indexPath.row) {
        case 0:
        {
            cell.iconView.image = [UIImage imageNamed:@"icon_support"];
            cell.titleLabel.text = @"点赞";
        }
            break;
        case 1:
        {
            cell.iconView.image = [UIImage imageNamed:@"icon_comment"];
            cell.titleLabel.text=@"评论";
        }
            break;
        case 2:
        {
            cell.iconView.image = [UIImage imageNamed:@"icon_aite"];
            cell.titleLabel.text = @"提到我的";
        }
            break;
        case 3:
        {
            cell.iconView.image = [UIImage imageNamed:@"icon_attention"];
            cell.titleLabel.text = @"关注我的";
        }
            break;
       
    }
    }
    else
    {

        if(indexPath.row==0)
        {
            
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"userif"];
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userif"];
            cell.textLabel.text=@"系统消息";
            cell.textLabel.textAlignment=NSTextAlignmentLeft;
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            
            UIButton *clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-80,cell.frame.size.height/2-2, 40, 20)];
            NSLog(@"%f",cell.frame.size.height/2);
            [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
            [clearBtn setBackgroundImage:[UIImage imageNamed:@"ablumBG"] forState:UIControlStateNormal];
            clearBtn.layer.cornerRadius = 5;
            clearBtn.clipsToBounds=YES;
            [clearBtn addTarget:self action:@selector(clearBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:clearBtn];
            return cell;

        }
    }
    return cell;
    
}
-(void)clearBtn
{
    NSLog(@"点击了晴空");
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
