//
//  MineFirst.m
//  Family
//
//  Created by Julis on 16/7/1.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "MineFirst.h"
#import "NameController.h"
#import "SexController.h"
#import "PersonPen.h"
#import "TLCityPickerController.h"
#import "PicturePickerVC.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SDWebImageManager.h"
#import "FirstMineInformationModel.h"
#import "AllpersonInformationModell.h"
#define WidthW [UIScreen mainScreen].bounds.size.width
@interface MineFirst ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TLCityPickerDelegate,UIActionSheetDelegate>
{
    UILabel *nameLabel;
    NSArray *dataSource;
    PicturePickerVC *pickerVc;
    NSString *personpenStr;
    UILabel *cityLabel;
    UIImageView *headImageView;
    AllpersonInformationModell *model;
    UILabel *sexLabel;
    UISwitch *switchView;
    UILabel *personpenLabel;
    
}
@property (nonatomic, assign) id<UIActionSheetDelegate>delegate;
@property (nonatomic,copy) UIScrollView * scrollView;
@end

@implementation MineFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled=NO;//禁止tableview移动
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"个人信息"];
    dataSource=@[@"用户名",@"性别",@"地区",@"个性签名"];
    personpenStr=@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    [self loadData];
    [self frameOfCell];
}


-(void)frameOfCell
{
    headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WidthW-104, 10, 64, 64)];
    headImageView.image=[UIImage imageNamed:@"icon_person"];
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthW-40-100, 15, 100, 20)];
    sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthW-60, 15, 20, 20)];
    sexLabel.text=@"男";
    sexLabel.textColor=[UIColor grayColor];
    nameLabel.text=_name;
    nameLabel.textAlignment=NSTextAlignmentRight;
    nameLabel.textColor=[UIColor grayColor];
    cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthW-140-40, 15, 140, 20)];
    cityLabel.textAlignment=NSTextAlignmentRight;
    cityLabel.text=@"北京东城区";
    cityLabel.textColor=[UIColor grayColor];
    personpenLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthW- 150 -40, 15, 150, 20)];
    personpenLabel.text=@"哈哈哈哈哈哈";
    personpenLabel.textAlignment=NSTextAlignmentRight;
    personpenLabel.textColor=[UIColor grayColor];
    switchView = [[UISwitch alloc]initWithFrame:CGRectMake(WidthW-60,8, 15, 15)];
    switchView.transform = CGAffineTransformMakeScale(0.75, 0.75);
    switchView.on = NO;


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
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 20;
}
//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==2)
    return 20;
    
    return 0;
}
//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 90;
    }
    
    return 50;
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
        cell.textLabel.text=@"头像";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if(model)
           {
               SDWebImageManager *mag = [SDWebImageManager sharedManager];
               [mag downloadImageWithURL:[NSURL URLWithString:model.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                   headImageView.image = image;
               }];
               headImageView.layer.cornerRadius = 32;
               headImageView.clipsToBounds=YES;
           }
       [cell.contentView addSubview:headImageView];
    }
    else if (indexPath.section==1)
    {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text=[dataSource objectAtIndex:indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                if(model)
                nameLabel.text = model.username;
                [cell addSubview:nameLabel];
            }
                break;
             case 1:
            {
            if(model)
            {
                if([model.sex isEqualToString:@"1"])
                {
                    sexLabel.text=@"男";// 0  代表男士
                }
                
                else
                {
                     sexLabel.text=@"女";// 1  代表女
                }
               
            }
                 [cell addSubview:sexLabel];
            }
                break;
            case 2:
            {
               if(model)
                cityLabel.text = model.address;
                [cell addSubview:cityLabel];

            }
                break;
            case 3:
            {
                if(model)
                personpenLabel.text=model.info;
                [cell addSubview:personpenLabel];
                
            }
                break;
         
        }
       

    }
    else if(indexPath.section==2)
    {
        cell.textLabel.text=@"允许亲友圈管理员帮我完善资料";
        //cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.textAlignment=NSTextAlignmentLeft;
                if(model)
        {
            if([model.isallowed isEqualToString:@"1"])
                switchView.on = YES;
            else
                switchView.on = NO;
        }
        [cell addSubview:switchView];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        [self clickToChoose];

    }
    else if(indexPath.section==1)
    {
        switch (indexPath.row){
            case 0:
            {
                NameController *nameVc = [[NameController alloc]init];
                nameVc.name=nameLabel.text;
                [self.navigationController pushViewController:nameVc animated:YES];
            }
                break;
             case 1:
            {
                
                SexController *sexVc = [[SexController alloc]init];
                [self.navigationController pushViewController:sexVc animated:YES];
            }
                break;
            case 2:
            {
                TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
                
                [cityPickerVC setDelegate:self];
                
                cityPickerVC.locationCityID = @"1400010000";
                //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
                cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
                
                [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
                    
                }];

            }
                break;
            case 3:
            {
                PersonPen *personVc = [[PersonPen alloc]init];
                personVc.personpenStr = personpenLabel.text;
                [self.navigationController pushViewController:personVc animated:YES];
            }
                break;
        }
      
    }
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
     cityLabel.text = city.cityName;
    [cityPickerViewController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - PicturePicker
-(void)clickToChoose
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
    
    [mgr POST:@"http://139.196.34.170/familyweb/mine/mineinfo.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--%@",responseObject);
        
        model = [AllpersonInformationModell mj_objectWithKeyValues:responseObject];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--%@",error);
        
    }];
    
}

@end
