//
//  AboutTableViewController.m
//  Family
//
//  Created by Julis on 16/7/10.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "AboutTableViewController.h"
#import "ServiceAgreement.h"
#define WidthW [UIScreen mainScreen].bounds.size.width
@interface AboutTableViewController ()<UITableViewDelegate>
@property (nonatomic,strong) UIBarButtonItem *rightItem;
@end

@implementation AboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"关于家享"];
    self.view.backgroundColor=[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     if(section==0)
    return 3;
    return 0;
}

//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        if(indexPath.row==0)
            return 190;
    
        return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userinfo"];
        if(indexPath.row!=0)
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    if (indexPath.section==0)
    {
        switch (indexPath.row) {
            case 0:
            {
                cell.backgroundColor=[UIColor colorWithRed:244.0 green:244.0 blue:244.0 alpha:0.5];
                
                [self LogoAndDescribe:cell];
            }
                break;
            case 1:
                cell.textLabel.text=@"服务协议";
                break;
            case 2:
                cell.textLabel.text=@"喜欢我们，打分鼓励";
                break;
            default:
                break;
        }
      
            
    }
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        switch (indexPath.row) {
            case 0:

                break;
            case 1:
            {
                ServiceAgreement *vc = [[ServiceAgreement alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
-(void)LogoAndDescribe:(UITableViewCell *)cell
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(WidthW/2-45, 25, 90, 90)];
    UILabel *describe = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, WidthW, 100)];
    describe.text = @"当前版本 ：1.0684";
    describe.textColor=[UIColor grayColor];
    describe.textAlignment=NSTextAlignmentCenter;
    [imgView setImage:[UIImage imageNamed:@"logo_home"]];
    [cell addSubview:describe];
    [cell addSubview:imgView];
    
}
@end
