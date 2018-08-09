//
//  IndexRelationshipTableViewController.m
//  Family
//
//  Created by Julis on 16/7/15.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "IndexRelationshipTableViewController.h"
#import "IndexRelationshipCell.h"
#import "contactsTableViewCell.h"
#import "contactsTableViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface IndexRelationshipTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation IndexRelationshipTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setExtraCellLineHidden: (UITableView *)tableView


{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    
}

#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    return 2;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 2;
    return 5;
}
//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 45;
    }
    return 54;
}
//设置每组上面预留高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==2)
        return 20;
    return 0;
}

//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    if (indexPath.section==0)
    {
        IndexRelationshipCell *cell = [IndexRelationshipCell cellWithTableView:tableView];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
            {
                cell.iconView.image=[UIImage imageNamed:@"icon_contacts"];
                cell.titleLabel.text=@"通讯录邀请亲友";
                cell.titleLabel.font=[UIFont systemFontOfSize:14.0];
            }
                break;
            case 1:
            {
                cell.iconView.image=[UIImage imageNamed:@"icon_wechat"];
                cell.titleLabel.text=@"微信邀请亲友";
                cell.titleLabel.font=[UIFont systemFontOfSize:14.0];
            }
                break;
         
        }
        
        
         return cell;
    }
    else
    {
        contactsTableViewCell *cell = [contactsTableViewCell cellWithTableView:tableView];
        cell.iconView.layer.cornerRadius = 20;
        cell.iconView.layer.masksToBounds = YES;
        cell.iconinvitePerson.image = [UIImage imageNamed:@"icon_contacts"];
        cell.iconinvitePerson.layer.cornerRadius = 7.5;
        cell.iconinvitePerson.layer.masksToBounds = YES;
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60-20, cell.frame.size.height/2-10, 50, 20)];
        
        [btn setTitle:@"邀请进入" forState:UIControlStateNormal];
        btn.titleLabel.font= [UIFont systemFontOfSize:10.0f];
        [btn setBackgroundImage:[UIImage imageNamed:@"lightgreen"] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds=YES;
        [cell addSubview:btn];
        
        
        return cell;
    }
        
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
    }
    else if(indexPath.section==1)
    {
        contactsTableViewController *vc = [[contactsTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


@end
