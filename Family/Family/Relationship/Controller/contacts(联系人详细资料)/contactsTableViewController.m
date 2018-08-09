//
//  contactsTableViewController.m
//  Family
//
//  Created by Julis on 16/7/23.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "contactsTableViewController.h"
#import "competInfoTableViewController.h"
#import "nicknameSet.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "MJExtension.h"
#import "contactsModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface contactsTableViewController ()
{
    UIImageView *iconHeadView;
    UILabel *userNameLabel;
    UILabel *IDlabel;
    UILabel *localLabel;
    UILabel *phoneNumLabel;
    contactsModel *model;
    UILabel *nameLabel;
}
@end

@implementation contactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationSet];
   
    [self frameOfCellSet];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)navigationSet
{
    [self.navigationItem setTitle:@"详细资料"];
    self.view.backgroundColor = [UIColor colorWithRed:0.9176 green:0.9176 blue:0.9451 alpha:1.0];
    
}
-(void)frameOfCellSet
{
    NSString *id =@"8445445";
    NSString *name = @"李达";
    iconHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    iconHeadView.image = [UIImage imageNamed:@"icon_person"];
    iconHeadView.layer.cornerRadius=25;
    iconHeadView.clipsToBounds = YES;
    
    userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 100, 20)];
    userNameLabel.text = @"落叶挽歌";
    userNameLabel.font = [UIFont systemFontOfSize:14.0f];
    
    IDlabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 100, 20)];
    IDlabel.text = [NSString stringWithFormat:@"ID:%@",id] ;
    IDlabel.textColor = [UIColor lightGrayColor];
    IDlabel.font = [UIFont systemFontOfSize:12.0f];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 45, 100, 20)];
    nameLabel.textColor = [UIColor lightGrayColor];
    nameLabel.text = [NSString stringWithFormat:@"姓名:%@",name];
    nameLabel.font = [UIFont systemFontOfSize:12.0f];
    
    
    phoneNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 15, WIDTH-140, 20)];
    phoneNumLabel.textAlignment = NSTextAlignmentRight;
    phoneNumLabel.text =@"15881647985";
    phoneNumLabel.font = [UIFont systemFontOfSize:15.0f];
    phoneNumLabel.textColor = [UIColor colorWithRed:0.1529 green:0.7733 blue:0.0843 alpha:1.0];
    
    
    localLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 15, WIDTH-140, 20)];
    localLabel.textAlignment = NSTextAlignmentRight;
    localLabel.text = @"浙江 温州";
}
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    return 3;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if(section==1) {
        return 1;
    }else
        return 3;
}
//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 70;
    }
    if(indexPath.section==2)
    {
        if(indexPath.row == 2)
            return 80;
        else
            return 50;
    }
    return 50;
}
//设置每组上面预留高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
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

    
    static NSString *identifer=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    
    if (indexPath.section==0)
    {
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(model)
        {
            SDWebImageManager *mag = [SDWebImageManager sharedManager];
            [mag downloadImageWithURL:[NSURL URLWithString:model.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                iconHeadView.image = image;
                iconHeadView.layer.cornerRadius=25;
                iconHeadView.clipsToBounds = YES;
            }];
            IDlabel.text = model.pid;
            userNameLabel.text = model.nickname;
            nameLabel.text = model.name;
        }
        [cell addSubview:nameLabel];
        [cell addSubview:IDlabel];
        [cell addSubview:userNameLabel];
        [cell addSubview:iconHeadView];
    }
    
    else if(indexPath.section == 1)
    {
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"设置备注和标签";
    }
    else
    {
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row)
        {
            case 0:
            {
                cell.textLabel.text  =@"手机号码";
               if(model)
               {
                   phoneNumLabel.text = model.phone;
               }
                [cell.contentView addSubview:phoneNumLabel];
            }
                break;
               
            case 1:
            {
                cell.textLabel.text  =@"现居地";
                localLabel.text = model.city;
                [cell.contentView addSubview:localLabel];
            }
                break;
           
             case 2:
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text  =@"个人相册";

                if(model)
                {

                    float width = (WIDTH-100-30)/3;
                    for(int i=0;i<model.photo.count;i++)
                    {
                        SDWebImageManager *mag = [SDWebImageManager sharedManager];
                        [mag downloadImageWithURL:[NSURL URLWithString:model.photo[i]] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            UIImageView *imageView= [[UIImageView alloc]init];
                            imageView.frame = CGRectMake(95+width*i, (80-(width-10))/2, width-10, width-10);
                            imageView.image = image;
                            [cell addSubview:imageView];
                        }];
                        
                        
                        if(i==3)
                            break;
                    }
                }
                
                
            }
                break;
               
        }
    }
    
    return cell;
}

-(void)competInfoBtn
{
    NSLog(@"%@",model.isallow);
    UIButton *competInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 380, WIDTH-40, 40)];
    competInfoBtn.backgroundColor  = [UIColor colorWithRed:0.1176 green:0.6314 blue:0.0784 alpha:1.0];
   
    competInfoBtn.layer.cornerRadius = 5;
    competInfoBtn.clipsToBounds = YES;
    [competInfoBtn setTitle:@"完善资料" forState:UIControlStateNormal];
    [self.view addSubview:competInfoBtn];
    [competInfoBtn addTarget:self action:@selector(competiInfo) forControlEvents:UIControlEventTouchUpInside];
    if(model)
    {
        if([model.isallow isEqualToString:@"0"])
        {
            [competInfoBtn setHidden:YES];
        }
    }
}

-(void)competiInfo
{
    competInfoTableViewController *vc = [[competInfoTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
        {
            nicknameSet *Vc = [[nicknameSet alloc]init];
            [self.navigationController pushViewController:Vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
#pragma LoadData
-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *pra = [NSMutableDictionary dictionary];
    
    [mgr POST:@"http://139.196.34.170/familyweb/person/personinfo.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--%@",responseObject);
        //        for (NSDictionary *dict in responseObject[@"data"]) {
        model = [contactsModel mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
         [self competInfoBtn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--%@",error);
        
    }];
    
}
@end
