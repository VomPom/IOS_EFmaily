//
//  discussTableViewController.m
//  Family
//
//  Created by Julis on 16/7/22.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "discussTableViewController.h"
#import "BaseCell.h"
#import "MPOpenReplyViewController.h"
#import "discussModel.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "MJExtension.h"
#import "discussModel.h"
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface discussTableViewController ()<UITableViewDelegate>
{
    UIView *bgView;
}
@property (nonatomic,strong) NSMutableArray *modelArray;
@end

@implementation discussTableViewController

-(NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self NavitionSet];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 88;
    [self loadData];
    //[self inReplyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)NavitionSet
{
    self.navigationItem.title = @"评论";
}

-(void)discussViewSet
{
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-49-20, WIDTH, 69)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(inReplyView)];

        UIView *whiteView =[ [UIView alloc]initWithFrame:CGRectMake(10, 5, WIDTH-20, 59)];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [bgView addSubview:whiteView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, WIDTH-20, 20)];
    label.textColor = [UIColor lightGrayColor];
    label.text = @"说点什么吧...";
    [whiteView addSubview:label];
    [whiteView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];

}
-(void)viewDidAppear:(BOOL)animated
{
     [self discussViewSet];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [bgView removeFromSuperview];
}

- (void)inReplyView
{
    
    MPOpenReplyViewController *vc = [[MPOpenReplyViewController alloc]init];
    vc.bgImg = [vc screenShot];
    [self presentViewController:vc animated:NO completion:nil];
    
}
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"cell";
    BaseCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"BaseCell" owner:nil options:nil].lastObject;
    }
    cell.usernameLabel.text=@"落叶挽歌";
    cell.iconView.image = [UIImage imageNamed:@"icon_person"];
    discussModel *model = self.modelArray[indexPath.row];
    if(model)
    {
        SDWebImageManager *mag = [SDWebImageManager sharedManager];
        [mag downloadImageWithURL:[NSURL URLWithString:model.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            cell.iconView.image = image;
            cell.iconView.layer.cornerRadius = 20;
            cell.iconView.clipsToBounds=YES;
        }];
        cell.usernameLabel.text  = model.title;
        cell.describeLabel.text  = model.content;
        cell.timeLabel.text      = model.time;
    }
    
        
 

    return cell;
    
    
}

#pragma loadData
-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *pra = [NSMutableDictionary dictionary];
    //    pra[@"p"] = @"9";
    //
    //    [mgr POST:@"http://10.220.16.206:8080/index/fristindex.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    [mgr POST:@"http://139.196.34.170/familyweb/photo/photocommentlist.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"--%@",responseObject);
        for(NSDictionary *dict in responseObject)
        {
         discussModel  *model = [discussModel mj_objectWithKeyValues:dict];
            
        [self.modelArray addObject:model];
            
        }
        [self.tableView reloadData];
        
    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"--%@",error);
          
      }];
    
}

@end
