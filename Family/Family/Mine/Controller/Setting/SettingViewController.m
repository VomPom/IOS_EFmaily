//
//  SettingViewController.m
//  Family
//
//  Created by Julis on 16/7/2.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "SettingViewController.h"
#import "ChangePassword.h"
#import "AboutTableViewController.h"
#import "SuggestionsViewController.h"
#define HeightH   [UIScreen mainScreen].bounds.size.height
#define WidthH   [UIScreen mainScreen].bounds.size.width
@interface SettingViewController ()
{
        UILabel *warningText;
        int num;
        NSTimer *timer;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled=NO;//禁止tableview移动
    [self.navigationItem setTitle:@"设置"];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    return 3;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    return 2;
    else  if(section==1)
        return 2;
    else
        return 1;
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 20;
}
//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
}
//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userinfo"];
        if(indexPath.section!=2)
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  
   
    if (indexPath.section==0)
    {
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==0)
            cell.textLabel.text=@"修改密码";
        else
            cell.textLabel.text=@"清除缓存";
    }
   else if (indexPath.section==1)
    {
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==0)
            cell.textLabel.text=@"意见反馈";
        else
            cell.textLabel.text=@"关于家享";
    }
    
    else
    {
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text=@"退出登陆";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        
        switch (indexPath.row) {
            case 0:
            {
                ChangePassword *ChangePasswordVc = [[ChangePassword alloc]init];
                [self.navigationController pushViewController:ChangePasswordVc animated:YES];
            }
                break;
             case 1:
            {
                [self warningLabelText];
            }
                break;
                
            
            default:
                break;
        }
    }
    else if(indexPath.section==1)
    {
        switch (indexPath.row) {
           
            case 0:
            {
                SuggestionsViewController *suggestVc = [[SuggestionsViewController alloc]init];
                [self.navigationController pushViewController:suggestVc animated:YES];
            }
                break;
            case 1:
            {
                AboutTableViewController *AboutTableVC = [[AboutTableViewController alloc]init];
                [self.navigationController pushViewController:AboutTableVC animated:YES];
            }
                break;
            default:
                break;
        }
        
    }
    
}
//弹窗显示Label
- (void) warningLabelText {
  
    warningText = [[UILabel alloc]initWithFrame:CGRectMake(WidthH/2-80, HeightH/2, 160, 90)];
    warningText.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    warningText.text = @" 清除缓存成功!";
    warningText.font = [UIFont systemFontOfSize:22.0];
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
        NSLog(@"%d",num);
    } else {
        //RunTime内存释放
        if (timer.isValid) {
            [timer invalidate];
        }
        timer=nil;
        [self dismissViewControllerAnimated:YES completion:nil];
        num =0;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationDelegate:self];
        warningText.alpha =0.0;
        [UIView commitAnimations];
        
    
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
