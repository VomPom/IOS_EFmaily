//
//  AlbumViewController.m
//  Family
//
//  Created by Julis on 16/7/13.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "AlbumViewController.h"
#import "STConst.h"
#import "STUI.h"
#import "UIView+ST.h"
#import "AlbumTableViewCell.h"
#import "IndexMineViewController.h"
#import "CPKenburnsView.h"
#import "SJAvatarBrower.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "MJExtension.h"
#import "albumModel.h"
#define KScreen_Width [UIScreen mainScreen].bounds.size.width
#define KScreen_Height [UIScreen mainScreen].bounds.size.height

const CGFloat BackGroupHeight = 260;
const CGFloat HeadImageHeight= 80;
#define WidthW [UIScreen mainScreen].bounds.size.width
@interface AlbumViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UITableView *demoTableView;
    UIView *BGView;
    CPKenburnsView *kenbunrsView;
    albumModel *model;
}

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    //    tableview init
    [self.view addSubview:self.TableView];
    //    kenbunrsView init
    [demoTableView addSubview:self.Kenbunrs];
    //    表头viewinit
    [demoTableView addSubview:self.headView];
    //    用户图像init
    [BGView addSubview:[self ueserImage]];
    //    用户名字init
    [BGView addSubview:self.userLable];
    
    [BGView addSubview:[self dataView]];
    //     加载Navigation
    [self NavigationSet];
  

}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     AlbumTableViewCell *cell =  [AlbumTableViewCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor colorWithRed:0.9059 green:0.9059 blue:0.9059 alpha:1.0];
    cell.describView.backgroundColor = [UIColor colorWithRed:0.9059 green:0.9059 blue:0.9059 alpha:1.0];
    cell.describView. selectable=NO;
    cell.dataLabel.textAlignment=NSTextAlignmentCenter;
    //tableView.separatorStyle=UIAccessibilityTraitLink;
    return cell;
}
#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
//每组高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)layout
{
    NSLog(@"asdg");
}
//导航栏设置
-(void)NavigationSet
{
    //导航栏标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthW, 44)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:18.0f];
        titleLabel.text = @"个人相册";
    self.navigationItem.titleView = titleLabel;
    //右边标题
    _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:nil];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
        titleAttr[NSForegroundColorAttributeName]=[UIColor whiteColor];
    [_rightItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem=_rightItem;
    
    // 1.去掉背景图片和底部线条
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

-(UITableView*)TableView
{
    demoTableView                         =[[UITableView alloc]init];
    demoTableView.delegate                =self;
    demoTableView.dataSource              =self;
    [demoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    demoTableView.frame                   =[UIScreen mainScreen].bounds;
    demoTableView.contentInset            =UIEdgeInsetsMake(BackGroupHeight, 0, 0, 0);
    demoTableView.tableFooterView         =[[UIView alloc]init];
    return demoTableView;
}

-(CPKenburnsView *)Kenbunrs
{
    kenbunrsView                          = [[CPKenburnsView alloc] initWithFrame:CGRectMake(0, -BackGroupHeight, KScreen_Width, BackGroupHeight)];
    kenbunrsView.image                    = [UIImage imageNamed:@"ablumBG"];
    return kenbunrsView;
}

-(UIView*)headView
{
    BGView                                =[[UIView alloc]init];
    BGView.backgroundColor                =[UIColor clearColor];
    BGView.frame                          =CGRectMake(0, -BackGroupHeight, KScreen_Width, BackGroupHeight);
    return BGView;
}
-(UIView *)dataView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2+20, HeadImageHeight+15+60+30, ScreenWidth/2-20, 40)];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/2-20)/3, 5, 2, 30)];
    line1.backgroundColor = [UIColor whiteColor];
    line1.alpha=0.3;
    [view addSubview:line1];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/2-20)/3*2,5, 2, 30)];
    line2.backgroundColor = [UIColor whiteColor];
    line2.alpha=0.3;
    [view addSubview:line2];
    
    // 照片数量
    UILabel *pictureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, (ScreenWidth/2-20)/3, 20)];
    pictureLabel.text=@"照片";
    pictureLabel.textAlignment=NSTextAlignmentCenter;
    pictureLabel.textColor = [UIColor whiteColor];
    pictureLabel.font = [UIFont systemFontOfSize:13.0f];
    [view addSubview:pictureLabel];
    UILabel *pictureNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth/2-20)/3, 20)];
    pictureNumberLabel.text=@"3";
    pictureNumberLabel.textAlignment=NSTextAlignmentCenter;
    pictureNumberLabel.textColor = [UIColor whiteColor];
    pictureNumberLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:pictureNumberLabel];
    
    
    // 点赞数量
    UILabel *supportLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-20)/3, 20, (ScreenWidth/2-20)/3, 20)];
    supportLabel.text=@"点赞";
    supportLabel.textAlignment=NSTextAlignmentCenter;
    supportLabel.textColor = [UIColor whiteColor];
    supportLabel.font = [UIFont systemFontOfSize:13.0f];
    [view addSubview:supportLabel];
    
    UILabel *supportNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-20)/3, 0, (ScreenWidth/2-20)/3, 20)];
    supportNumberLabel.text=@"5";
    supportNumberLabel.textAlignment=NSTextAlignmentCenter;
    supportNumberLabel.textColor = [UIColor whiteColor];
    supportNumberLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:supportNumberLabel];
    
    
    
    //访问数量
    UILabel *visitLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-20)/3*2, 20, (ScreenWidth/2-20)/3, 20)];
    visitLabel.text=@"访问";
    visitLabel.textAlignment=NSTextAlignmentCenter;
    visitLabel.textColor = [UIColor whiteColor];
    visitLabel.font = [UIFont systemFontOfSize:13.0f];
    [view addSubview:visitLabel];
    
    UILabel *visitNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-20)/3*2, 0, (ScreenWidth/2-20)/3, 20)];
    visitNumberLabel.text=@"6";
    visitNumberLabel.textAlignment=NSTextAlignmentCenter;
    visitNumberLabel.textColor = [UIColor whiteColor];
    visitNumberLabel.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:visitNumberLabel];
    
    return view;
}
-(UIImageView *)ueserImage
{
    self.headImageView=[[UIImageView alloc]init];
    self.headImageView.layer.masksToBounds     =YES;
    self.headImageView.layer.borderWidth       =1;
    self.headImageView.layer.cornerRadius      =40;
    self.headImageView.contentMode             =UIViewContentModeScaleAspectFill;
    self.headImageView.layer.borderColor       =[[UIColor whiteColor] CGColor];
    self.headImageView.image = [UIImage imageNamed:@"icon_person"];
    
    self.headImageView.frame                   =CGRectMake((KScreen_Width-HeadImageHeight)/2, 15, HeadImageHeight, HeadImageHeight);
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtapGesture)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    //给self.view添加一个手势监测；
    _headImageView.userInteractionEnabled=YES;
    [_headImageView addGestureRecognizer:singleRecognizer];
    
    return _headImageView;
}
- (void)viewtapGesture
{
    [SJAvatarBrower showImage:_headImageView];//调用方法
}
-(UILabel *)userLable
{
   
    self.nameLabel.layer.masksToBounds        =YES;
    //self.nameLabel.layer.cornerRadius         =10;
    self.nameLabel.font                       =[UIFont systemFontOfSize:16.0];
    self.nameLabel.textAlignment              =NSTextAlignmentCenter;
    self.nameLabel.frame                      =CGRectMake(0, CGRectGetMaxY(_headImageView.frame)+10, WidthW, 20);
    //self.nameLabel.backgroundColor            =[UIColor whiteColor];
    self.nameLabel.textColor                  =[UIColor whiteColor];
    return self.nameLabel;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset        = scrollView.contentOffset.y;
    CGFloat xOffset        = (yOffset + BackGroupHeight)/2;
    
    if (yOffset < -BackGroupHeight) {
        
        CGRect rect        = kenbunrsView.frame;
        rect.origin.y      = yOffset;
        rect.size.height   =  -yOffset ;
        rect.origin.x      = xOffset;
        rect.size.width    = KScreen_Width + fabs(xOffset)*2;
        kenbunrsView.frame = rect;
    }
    
  //  CGFloat alpha          = (yOffset+BackGroupHeight)/BackGroupHeight;
    
   // [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    
//    alpha                  =fabs(alpha);
//    alpha                  =fabs(1-alpha);
//    alpha=alpha<0.2? 0:alpha-0.2;
//    BGView.alpha          =alpha;
    
    
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect           = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context  = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma loadData
-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *pra = [NSMutableDictionary dictionary];
    [mgr POST:@"http://139.196.34.170/mine/mineIndex.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--%@",responseObject);
        model = [albumModel mj_objectWithKeyValues:responseObject];
        SDWebImageManager *mag = [SDWebImageManager sharedManager];
        [mag downloadImageWithURL:[NSURL URLWithString:model.img] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            self.headImageView.image=image;
            
        }];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--%@",error);
        
    }];
    
}
@end
