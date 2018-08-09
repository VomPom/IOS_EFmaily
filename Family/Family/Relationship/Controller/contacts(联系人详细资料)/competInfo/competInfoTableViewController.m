//
//  competInfoTableViewController.m
//  Family
//
//  Created by Julis on 16/7/23.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "competInfoTableViewController.h"
#import "changeOtherNameController.h"
#import "TLCityPickerController.h"
#import "changeOtherSexController.h"
#import "changeOtherPassword.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "MJExtension.h"
#import "competInfoModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface competInfoTableViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,TLCityPickerDelegate>
{
    UILabel *nameLabel;

    UILabel *cityLabel;
    
    UIImageView *headImageView;
    
    UILabel *sexLabel;
    
    UIButton *changeIconBtn;
    
    competInfoModel *model;
    
}
@end

@implementation competInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self competAndSendBtn];
    [self frameOfCell];
    [self loadData];
    [self navigationSet];
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

-(void)frameOfCell
{
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 20, 60, 60)];
    headImageView.image = [UIImage imageNamed:@"ablumBG"];
    headImageView.layer.cornerRadius = 30;
    headImageView.clipsToBounds =YES;
    changeIconBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-30, CGRectGetMaxY(headImageView.frame)+20, 60, 20)];
    
    [changeIconBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeIconBtn setTitle:@"更换头像" forState:UIControlStateNormal];
    [changeIconBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    changeIconBtn.backgroundColor = [UIColor lightGrayColor];
    changeIconBtn.layer.cornerRadius = 5;
    changeIconBtn.clipsToBounds = YES;
    [changeIconBtn addTarget:self action:@selector(clickToChoose) forControlEvents:UIControlEventTouchUpInside];
}
- (void)navigationSet
{
    [self.navigationItem setTitle:@"详细资料"];
    self.view.backgroundColor = [UIColor colorWithRed:0.9176 green:0.9176 blue:0.9451 alpha:1.0];
    
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
    if(section==0)
        return 0;
    
    return 30;
}

//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 160;
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
    if(indexPath.section!=0)
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    //选中无颜色变化
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            
            if(indexPath.section == 0)
            {
                cell.backgroundColor = [UIColor colorWithRed:0.9451 green:0.9451 blue:0.9451 alpha:1.0];
                if(model)
                {
                    SDWebImageManager *mag = [SDWebImageManager sharedManager];
                    [mag downloadImageWithURL:[NSURL URLWithString:model.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        headImageView.image = image;
    
                    }];
                }
                
                [cell addSubview:changeIconBtn];
                [cell addSubview:headImageView];
            }
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"落叶挽歌";
            if(model)
            {
                cell.textLabel.text = model.name;
            }
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"浙江温州";
            if(model)
            {
                cell.textLabel.text = model.city;
            }
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"男";
            if([model.sex isEqualToString:@"0"])
            {
                 cell.textLabel.text = @"男";
            }
            else
                 cell.textLabel.text = @"女";
        }
            break;
      
    }
    
    
    
    return cell;
}
-(UIView *)viewOfHeader:(NSString *)text
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -5, WIDTH, 30)];
   UILabel  *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH, 30)];
    headerLabel.text =text;
      view.backgroundColor = [UIColor colorWithRed:0.9647 green:0.9647 blue:0.9647 alpha:1.0];
    headerLabel.textColor = [UIColor colorWithRed:0.502 green:0.498 blue:0.5294 alpha:1.0];
    headerLabel.font =[UIFont systemFontOfSize:12.0f];
    [view addSubview:headerLabel];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    switch (section)
    {
        case 1:
        {
            return [self viewOfHeader:@"名字"];
        }
            break;
        case 2:
        {
            return [self viewOfHeader:@"现居地"];
        }
            break;
        case 3:
        {
            return [self viewOfHeader:@"性别"];
        }
            break;
        case 4:
        {
            return [self viewOfHeader:@"密码"];
        }
            break;
            
    }
    return 0;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, -5, WIDTH, 50)];
    textLabel.text = @"关闭后，将只有你一个人可以邀请亲友加入亲友圈";
    textLabel.textColor = [UIColor colorWithRed:0.4548 green:0.0412 blue:0.1037 alpha:1.0];
    textLabel.font =[UIFont systemFontOfSize:13.0f];
    view.backgroundColor = [UIColor colorWithRed:0.9556 green:0.1211 blue:0.1669 alpha:1.0];
    [view addSubview:textLabel];
    NSLog(@"d");
 
        return view;
    
   
}

-(void)competAndSendBtn
{
    UIButton *competInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 420, WIDTH-40, 40)];
    competInfoBtn.backgroundColor  = [UIColor colorWithRed:0.1176 green:0.6314 blue:0.0784 alpha:1.0];
    competInfoBtn.layer.cornerRadius = 5;
    competInfoBtn.clipsToBounds = YES;
    [competInfoBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.tableView addSubview:competInfoBtn];
    [competInfoBtn addTarget:self action:@selector(competAndSend) forControlEvents:UIControlEventTouchUpInside];
}
-(void)competAndSend
{
    NSLog(@"发送");
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
        {
            changeOtherNameController *Vc = [changeOtherNameController alloc];
            [self.navigationController pushViewController:Vc animated:YES];
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
            changeOtherSexController *sexVc = [[changeOtherSexController alloc]init];
            [self.navigationController pushViewController:sexVc animated:YES];
        }break;
            
        default:
            break;
    }
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
#pragma LoadData
-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *pra = [NSMutableDictionary dictionary];
    
    [mgr POST:@"http://139.196.34.170/familyweb/person/personinfochange.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--%@",responseObject);
        //        for (NSDictionary *dict in responseObject[@"data"]) {
        model = [competInfoModel mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--%@",error);
        
    }];
    
}


@end
