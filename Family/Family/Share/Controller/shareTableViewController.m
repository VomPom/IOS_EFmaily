//
//  shareTableViewController.m
//  Family
//
//  Created by Julis on 16/7/15.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "shareTableViewController.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "MJExtension.h"
#import "shareModel.h"
#import "ZeroSelectListItem.h"
#import "ZeroSelectListViewController.h"
#import "sendPhotosViewController.h"
#import "discussTableViewController.h"
#import "MPOpenReplyViewController.h"

#define HEIGHT   [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface shareTableViewController () <UITableViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic, strong) ZeroSelectListViewController * selectListVC;
@property (nonatomic, strong) NSMutableArray * selectListItems;
@end

@implementation shareTableViewController
// 懒加载
-(NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self navigationSet];
    self.selectListItems = [NSMutableArray arrayWithCapacity:0];
    [self loadListItems];
   
    
}
-(void)navigationSet
{
   
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
   self.navigationItem.rightBarButtonItem = [self itemWithTarget:self action:@selector(rightBarBtnClick) image:@"add" highImage:@"add_hl"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    return 1;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if(section==0)
     return self.modelArray.count;
     else
        return 3;
}
//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return WIDTH;
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
        

        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userinfo"];
        //选中无颜色变化
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *iconHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        iconHeadView.image = [UIImage imageNamed:@"icon_person"];
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, WIDTH-40-10-10, 30)];
        nameLabel.text = @"落叶挽歌";
        nameLabel.font=[UIFont systemFontOfSize:13.0f];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50, WIDTH-20, WIDTH*0.618)];
        imageView.image = [UIImage imageNamed:@"ablumBG"];
       //设置imageview点击image放大图片手势
        
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCellImage)]];
       
       
        
        
        
        UIView *infoView = [[UIView alloc] initWithFrame:
                            CGRectMake(10, CGRectGetMaxY(imageView.frame)+30, WIDTH-10, 30)];
        [cell.contentView addSubview:infoView];

        
        //几个按钮
        UIButton *suportBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
        [suportBtn setImage:[UIImage imageNamed:@"icon_sport"] forState:UIControlStateNormal];
         UILabel *suportLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 5, 30, 30)];
        suportLabel.text=@"10";
        suportLabel.textColor = [UIColor lightGrayColor];
        suportLabel.font = [UIFont systemFontOfSize:10.f];
        [infoView addSubview:suportLabel];
        [infoView addSubview:suportBtn];
        
        
        UIButton *discussBtn = [[UIButton alloc]initWithFrame:CGRectMake(80, 0, 30, 30)];
        [discussBtn setImage:[UIImage imageNamed:@"icon_comment_share"] forState:UIControlStateNormal];
        UILabel *discussLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 5, 30, 30)];
        discussLabel.text=@"10";
        discussLabel.textColor = [UIColor lightGrayColor];
        discussLabel.font = [UIFont systemFontOfSize:10.f];
        [infoView addSubview:discussBtn];
        [infoView addSubview:discussLabel];
        
        //添加button方法
        [discussBtn addTarget:self action:@selector(pushTodiscussTableViewController) forControlEvents:UIControlEventTouchUpInside];
        // [discussBtn addTarget:self action:@selector(     inReplyView) forControlEvents:UIControlEventTouchUpInside];
   
        
        UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 0, 30, 30)];
        [moreBtn setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        [infoView addSubview:moreBtn];
        
        
        
       
        shareModel *model = self.modelArray[indexPath.row];
        if(model)
            {
                SDWebImageManager *mag = [SDWebImageManager sharedManager];
                [mag downloadImageWithURL:[NSURL URLWithString:model.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {                    iconHeadView.image=image;
                    iconHeadView.layer.cornerRadius=15;
                    iconHeadView.clipsToBounds=YES;
                }];
                
                [mag downloadImageWithURL:[NSURL URLWithString:model.img] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    imageView.image=image;

            }];
            nameLabel.text = model.username;
           
           
            // decribeView.text = model.text;
            //  [cell.contentView addSubview:decribeView];

        }
        
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:iconHeadView];
        [cell.contentView addSubview:nameLabel];
        [cell.contentView addSubview:infoView];
        
    }
    
    return cell;

    
}
-(void)pushTodiscussTableViewController
{
    discussTableViewController *vc = [[discussTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)inReplyView
{
    
    MPOpenReplyViewController *vc = [[MPOpenReplyViewController alloc]init];
    vc.bgImg = [vc screenShot];
    [self presentViewController:vc animated:NO completion:nil];
    
}
//选中cell弹出方法
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

//“＋”界面
-(void)loadListItems
{
    NSArray * images = @[[UIImage imageNamed:@"add_photos"], [UIImage imageNamed:@"add_story"]];
    NSArray * titles = @[@"",@"事"];
       [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        ZeroSelectListItem * item = [[ZeroSelectListItem alloc] initWithIconImage:images[idx]];

        [_selectListItems addObject:item];
    }];
}
/**
 *  导航右按钮点击
 */
- (void)rightBarBtnClick
{
    self.selectListVC = [[ZeroSelectListViewController alloc] initWithItems:_selectListItems];
    
    _selectListVC.alphaComponent        = 0.0;
    _selectListVC.showListViewControl   = self;
    
    _selectListVC.clickBlock = ^(NSInteger selectIndex)
    {
        switch (selectIndex) {
            case 0:
            {
                sendPhotosViewController *Vc = [[sendPhotosViewController alloc]init];
                [super.navigationController pushViewController:Vc animated:NO];
            }
                break;
                
            default:
                break;
        }
    };
    
    [_selectListVC show];
}

#pragma loadData
-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *pra = [NSMutableDictionary dictionary];
    //    pra[@"p"] = @"9";
//    
//    [mgr POST:@"http://10.220.16.206:8080/index/fristindex.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    [mgr POST:@"http://139.196.34.170/familyweb/index/fristindex.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"--%@",responseObject);
        for(NSDictionary *dict in responseObject)
        {
            shareModel *model = [shareModel mj_objectWithKeyValues:dict];
            [self.modelArray addObject:model];
            
        }
        [self.tableView reloadData];

    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--%@",error);
        
    }];
    
}

-(void)tapCellImage
{
    NSLog(@"adsg");
}



- (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    //CGSize size = btn.currentBackgroundImage.size;
    btn.bounds = CGRectMake(0, 0, 32, 32);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
