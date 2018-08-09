//
//  manageTableViewController.m
//  Family
//
//  Created by Julis on 16/7/21.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "manageTableViewController.h"
#import "PicturePickerVC.h"
#import "familyNameController.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "MJExtension.h"
#import "manageModel.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
@interface manageTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UIImageView *headImageView;
    manageModel *model;
    UILabel *describeLabel;
    UILabel *personNumLabel;
    UISwitch *switchView;
}

@end

@implementation manageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"管理页面"];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self cellOfFream];
    [self loadData];
    //self.view.backgroundColor = [UIColor colorWithRed:0.9587 green:0.9562 blue:1.0 alpha:1.0];
    self.tableView.scrollEnabled=NO;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    return 4;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==3)
        return 30;
    return 20;
}
//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==3)
    return 30;
    return 0;
}
//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 70;
    }
    
    return 50;
}
-(void)cellOfFream
{
    
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-84, 10, 50, 50)];
     describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-150-40, 15, 150, 20)];
     personNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-60, 15, 20, 20)];
    switchView = [[UISwitch alloc]initWithFrame:CGRectMake(WIDTH-80,10, 20, 20)];
}
//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if(indexPath.section!=3)
    {
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = @"亲友圈封面";
           
            headImageView.image = [UIImage imageNamed:@"icon_person"];
            if(model)
            {
                SDWebImageManager *mag = [SDWebImageManager sharedManager];
                [mag downloadImageWithURL:[NSURL URLWithString:model.icon] options:0 progress:nil
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
                {
                    headImageView.image =image;
                }];
                headImageView.layer.cornerRadius=25;
                headImageView.clipsToBounds=YES;
            }
            
            [cell addSubview:headImageView];
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"亲友圈名称";
           
            describeLabel.text=@"哈哈哈哈哈哈";
            describeLabel.textAlignment=NSTextAlignmentRight;
            describeLabel.textColor=[UIColor grayColor];
            describeLabel.font = [UIFont systemFontOfSize:14.0f];
            if(model)
            {
                describeLabel.text = model.name;
            }
            [cell addSubview:describeLabel];
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"全部亲友";
           
            personNumLabel.text=@"1";
            personNumLabel.textColor=[UIColor grayColor];
            if(model)
            {
                personNumLabel.text =model.count;
            }
            [cell addSubview:personNumLabel];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"允许其他亲友拉人";
            
            switchView.on = YES;
            if(model)
            {
                if([model.isallow isEqualToString:@"0"])
                    switchView.on = NO;
                else
                    switchView.on = YES;
            }
            [cell addSubview:switchView];
        }
            break;
        default:
            break;
    }
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, -5, WIDTH, 30)];
    textLabel.text = @"您可以帮助亲友修改名字、头像，也可以帮他们找回密码";
    view.backgroundColor = [UIColor colorWithRed:0.9647 green:0.9647 blue:0.9647 alpha:1.0];
    textLabel.textColor = [UIColor colorWithRed:0.502 green:0.498 blue:0.5294 alpha:1.0];
    textLabel.font =[UIFont systemFontOfSize:12.0f];
    [view addSubview:textLabel];

    if(section==3)
        return view;
    return 0;
        
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, -5, WIDTH, 30)];
    textLabel.text = @"关闭后，将只有你一个人可以邀请亲友加入亲友圈";
   textLabel.textColor = [UIColor colorWithRed:0.502 green:0.498 blue:0.5294 alpha:1.0];
    textLabel.font =[UIFont systemFontOfSize:12.0f];
    view.backgroundColor = [UIColor colorWithRed:0.9647 green:0.9647 blue:0.9647 alpha:1.0];
    [view addSubview:textLabel];
    if(section==3)
        return view;
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
             [self clickToChoosePicture];
        }
            break;
        case 1:
        {
            familyNameController *vc = [[familyNameController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
  
}
-(void)clickToChoosePicture
{
    
    _actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"来自相机",@"来自相册",nil];
    [_actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            [self selectImageByCaream];
            
        }
            break;
            
        case 1:
        {
            [self selectImageByLiabry];
        }
            break;
    }
}
//实现button点击事件的回调方法
- (void)selectImageByLiabry
{
    
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    //设置相册呈现的样式
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate = self;
    //使用模态呈现相册
    [self presentViewController:pickerController animated:YES completion:^{
        
    }];
    
}
- (void)selectImageByCaream
{
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:^{
        
    }];
    
}

//选择照片完成之后的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    
    
    //NSLog(@"%@",info);
    //刚才已经看了info中的键值对，可以从info中取出一个UIImage对象，将取出的对象赋给按钮的image
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //裁成边角
    headImageView.layer.cornerRadius = 32;
    headImageView.layer.masksToBounds = YES;
    [headImageView setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma loadData
-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *pra = [NSMutableDictionary dictionary];
    //    pra[@"p"] = @"9";
    
    [mgr POST:@"http://139.196.34.170/familyweb/home/homesetting.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--%@",responseObject);
        
            model = [manageModel mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--%@",error);
        
    }];
    
}

@end
