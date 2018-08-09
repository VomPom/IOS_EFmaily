//
//  IndexMineViewController.m
//  Family
//
//  Created by ZHC on 16/6/30.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "IndexMineViewController.h"
#import "MineFirst.h"
#import "SettingViewController.h"
#import "MessageMineController.h"
#import "MineFirstCell.h"
#import "MineTableViewCell.h"
#import "AlbumViewController.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "FirstMineInformationModel.h"
#import "MJExtension.h"
#define HeightH   [UIScreen mainScreen].bounds.size.height
#define WidthW [UIScreen mainScreen].bounds.size.width
@interface IndexMineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataSource;
    UILabel *warningText;
    int num;
    NSTimer *timer;
    FirstMineInformationModel *model;
}
@end

@implementation IndexMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled=NO;//禁止tableview移动

    dataSource=@[@"我的相册",@"我的消息",@"我的设置"];
    self.nameStr=@"落叶挽歌";
    _headImage=[UIImage imageNamed:@"icon_person"];
    [self loadData];
    
   
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
        return dataSource.count;
    }else
        return 1;
}
//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 90;
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
    
   
    
    
    if (indexPath.section==0)
    {
        
        MineFirstCell *cell = [MineFirstCell cellWithTableView:tableView];
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.HeadIcon.image = _headImage;
        cell.nameLabel.frame=CGRectMake(cell.frame.origin.x-150-40, cell.frame.origin.y, 150, cell.frame.size.width);
        cell.nameLabel.text=@"落叶挽歌";
        cell.phonenumberLabel.text=[NSString stringWithFormat:@"电话:1588168255"];
        cell.sexIcon.image=[UIImage imageNamed:@"icon_girl_sex"];
       
        //创建二维码
        UIButton *erweimaBtn = [[UIButton alloc]initWithFrame:CGRectMake(WidthW-40-30, 45-20, 40, 40)];
        [erweimaBtn setBackgroundImage:[UIImage imageNamed:@"icon_erweima"] forState:UIControlStateNormal];
        //设置二维码事件
        //[erweimaBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:erweimaBtn];
        
        // 服务器加载数据
        if(model)
        {
            SDWebImageManager *mag = [SDWebImageManager sharedManager];
            [mag downloadImageWithURL:[NSURL URLWithString:model.img] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                cell.HeadIcon.image = image;
                cell.HeadIcon.layer.cornerRadius=30;
                cell.HeadIcon.clipsToBounds = YES;
            }];
            
        }
        
        cell.nameLabel.text = model.username;
        cell.phonenumberLabel.text =[NSString stringWithFormat:@"手机:  %@",model.phone];
        if([model.sex isEqualToString:@"0"])
        {
            cell.sexIcon.image = [UIImage imageNamed:@"icon_boy_sex"];// 0  代表男士
        }
        else
        {
            cell.sexIcon.image = [UIImage imageNamed:@"icon_girl_sex"];// 1  代表女
        }
        
        
        return cell;
    }
    else if (indexPath.section==1)
    {
        
        MineTableViewCell *cell = [MineTableViewCell cellWithTableView:tableView];
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case 0:
            {
                cell.IconView.image=[UIImage imageNamed:@"icon_album"];
                cell.tietleLabel.text=dataSource[0];
            }
                break;
            case 1:
            {
                cell.IconView.image=[UIImage imageNamed:@"icon_message"];
                cell.tietleLabel.text=dataSource[1];
            }
                break;
            case 2:
            {
                cell.IconView.image=[UIImage imageNamed:@"icon_seting"];
                cell.tietleLabel.text=dataSource[2];
            }
                break;
            default:
                break;
        }
        return cell;
    }
    else
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"userif"];
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userif"];
        cell.textLabel.text=@"检查新版本";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
       MineFirst *detailVc = [[MineFirst alloc]init];
        detailVc.name=self.nameStr;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
    else if(indexPath.section==1)
    {
        switch (indexPath.row)
        {
            case 0:
            {

                AlbumViewController *albumVc = [[AlbumViewController alloc]init];
                albumVc.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthW/2-50, 140, 100, 100)];
                albumVc.nameLabel.text=model.username;
                [self.navigationController pushViewController:albumVc animated:YES];
            }
                break;
            case 1:
            {
                MessageMineController *vc = [[MessageMineController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
               
            }
                break;
            case 2:
            {
                SettingViewController  *detailView = [[SettingViewController  alloc]init];
                [self.navigationController  pushViewController:detailView animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else if(indexPath.section==2)
    {
        [self  warningLabelText];
    }
    
}
#pragma mark Check New version

//弹窗显示Label
- (void) warningLabelText {
    
    warningText = [[UILabel alloc]initWithFrame:CGRectMake(WidthW/2-80, HeightH/2-80*2, 160, 70)];
    warningText.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    warningText.text = @" 已经是最新版本!";
    warningText.font = [UIFont systemFontOfSize:18.0];
    warningText.textAlignment = NSTextAlignmentCenter;
    warningText.layer.cornerRadius = 10;
    warningText.clipsToBounds = YES;
    [self.view addSubview:warningText];
    [self shakeToUpShow:warningText];
    [self runTime];
}

//弹出动画效果
- (void) shakeToUpShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

//消失动画效果
- (void) runTime {
    timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(method_time) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    num = 0;
}

//runtime控制器
- (void)method_time {
    if (num < 1) {
        num++;
    }
    else {
        //RunTime内存释放
        if (timer.isValid) {
            [timer invalidate];
        }
        timer=nil;
        [self dismissViewControllerAnimated:YES completion:nil];
        num =0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.9];
        [UIView setAnimationDelegate:self];
        warningText.alpha =0.0;
        [UIView commitAnimations];
    }
}
#pragma loadData
-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *pra = [NSMutableDictionary dictionary];
    //    pra[@"p"] = @"9";
    
    [mgr POST:@"http://139.196.34.170/familyweb/mine/mineIndex.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--%@",responseObject);
        //        for (NSDictionary *dict in responseObject[@"data"]) {
        
//        TravelModel *model = [TravelModel mj_objectWithKeyValues:responseObject];
       model = [FirstMineInformationModel mj_objectWithKeyValues:responseObject];
    
        [self.tableView reloadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--%@",error);
        
    }];
    
}


@end
