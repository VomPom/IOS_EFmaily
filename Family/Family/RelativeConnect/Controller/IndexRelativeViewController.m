//
//  IndexRelativeViewController.m
//  Family
//
//  Created by ZHC on 16/6/30.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "IndexRelativeViewController.h"
#import "clickRealtiveConnectViewController.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "MJExtension.h"
#import "relationshipModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface IndexRelativeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *modelArray;
@end

@implementation IndexRelativeViewController

-(NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9451 green:0.9451 blue:0.9451 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self loadData];
    [self seletePictureBtn];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)seletePictureBtn
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]init];
    rightItem = [[UIBarButtonItem alloc]initWithTitle:@"创建" style:UIBarButtonItemStyleDone target:self action:@selector(btn)];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName]=[UIColor colorWithRed:49/255.0 green:194/255.0 blue:125/255.0 alpha:1];
    [rightItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)btn
{
    NSLog(@"点击了创建");
}
-(void)setView
{

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, self.modelArray.count*WIDTH/2)];
    
       for(int i=0;i<self.modelArray.count;i++)
    {
        relationshipModel *model = self.modelArray[i];
        
        UIView *view = [self cellView:model];
        
        int row = i%2;
        int col = i/2;
        
        view.frame = CGRectMake(7.5+row*WIDTH/2, 10+col*(10+WIDTH/2), view.frame.size.width, view.frame.size.height);
        view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        view.layer.cornerRadius = 10;
        view.clipsToBounds =YES;
        UITapGestureRecognizer *tapGesturRecongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToPage)];
        [view addGestureRecognizer:tapGesturRecongnizer];
        [scrollView addSubview:view];
        
    }
    scrollView.contentSize = CGSizeMake(WIDTH, self.modelArray.count*WIDTH/1.7);
    [self.view addSubview:scrollView];
}
-(void)pushToPage
{
    clickRealtiveConnectViewController *Vc = [[clickRealtiveConnectViewController alloc]init];
   [self.navigationController pushViewController:Vc animated:YES];
}
-(UIView *)cellView:(relationshipModel *)model
{
    float viewWidth = WIDTH/2-15;
    int numOfRelative=0;
    int leavelNum= 0;

    UIScrollView *view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2-15, WIDTH/2)];
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth/2-(viewWidth/3+10)/2, 15,viewWidth/3+10 , viewWidth/3+10)];
    
    iconImage.image = [UIImage imageNamed:@"ablumBG"];
    iconImage.layer.cornerRadius=viewWidth/6+5;
    iconImage.clipsToBounds = YES;
    
    
    UILabel *famllyName = [[UILabel alloc]initWithFrame:CGRectMake(0, 30+viewWidth/3+5, WIDTH/2-15, 20)];
    famllyName.text =@"落叶挽歌的亲友圈";
    famllyName.textAlignment = NSTextAlignmentCenter;
    
    UILabel *relativewNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 30+viewWidth/3+10+20+10, WIDTH/2-15, 15)];
    relativewNum.text = [NSString stringWithFormat:@"共%d位亲友",numOfRelative];
    relativewNum.textAlignment = NSTextAlignmentCenter;
    relativewNum.textColor = [UIColor lightGrayColor];
    relativewNum.font = [UIFont systemFontOfSize:14.0f];
    
    
    
    UILabel *activeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30+viewWidth/3+10+20+20+20+10, WIDTH/2-15, 20)];
    activeLabel.text = [NSString stringWithFormat:@"圈子活跃度:%d级",leavelNum];
    activeLabel.textAlignment = NSTextAlignmentCenter;
    activeLabel.textColor = [UIColor colorWithRed:0.3333 green:0.7255 blue:0.8078 alpha:1.0];
    activeLabel.font = [UIFont systemFontOfSize:15.0f];
    if(model)
    {
        SDWebImageManager *mag = [SDWebImageManager sharedManager];
        [mag downloadImageWithURL:[NSURL URLWithString:model.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            iconImage.image = image;
        }];
        
        activeLabel.text =  activeLabel.text = [NSString stringWithFormat:@"圈子活跃度:%@级",model.level];
        relativewNum.text =[NSString stringWithFormat:@"共%@位亲友",model.count];
        famllyName.text   =model.title;
        
    }
    
    
    [view addSubview:activeLabel];
    [view addSubview:relativewNum];
    [view addSubview:famllyName];
    [view addSubview:iconImage];
    return view;
}
#pragma loaddta
#pragma loadData
-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *pra = [NSMutableDictionary dictionary];
    //    pra[@"p"] = @"9";
    
    [mgr POST:@"http://139.196.34.170/familyweb/home/homelist.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--%@",responseObject);
        for (NSDictionary *dict in responseObject) {
           relationshipModel *model = [relationshipModel mj_objectWithKeyValues:dict];
            [self.modelArray addObject:model];
        }
        [self setView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--%@",error);
     
    }];
    
}
@end
