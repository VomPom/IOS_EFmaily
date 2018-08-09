//
//  Example7ViewController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 15-4-3.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//
#import "IndexPhotographViewController.h"
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "MJExtension.h"
@interface IndexPhotographViewController () <ZLPhotoPickerBrowserViewControllerDelegate>
{
   int pictureCount;
}
@property (nonatomic , strong) NSMutableArray *assets;
@property (weak,nonatomic) UIScrollView *scrollView;

@end

@implementation IndexPhotographViewController

- (NSMutableArray *)assets{
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationSet];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    // 这个属性不能少
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 九宫格创建ScrollView
   
    }
-(void)navigationSet
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]init];
    [self.navigationItem setTitle:@"家庭相册"];
    rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发照片" style:UIBarButtonItemStyleDone target:self action:@selector(photoSelectet)];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName]=[UIColor colorWithRed:49/255.0 green:194/255.0 blue:125/255.0 alpha:1];
    [rightItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightItem;
}
- (UIScrollView *)scrollView{
    if (_scrollView==nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
       // scrollView.backgroundColor  = [UIColor redColor];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_scrollView = scrollView];
    }
    return _scrollView;
}

- (void)reloadScrollView{
    // 先移除，后添加
  // [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSUInteger column = 4;
    // 加一是为了有个添加button
    NSUInteger assetCount = self.assets.count + 1;
    CGFloat width = self.view.frame.size.width / column;
    for (NSInteger i = pictureCount; i < pictureCount+ assetCount; i++) {

        NSInteger row = i / column;
        NSInteger col = i % column;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.frame = CGRectMake(width * col, row * width, width, width);
        // UIButton
        if (i == self.assets.count+pictureCount){
            // 最后一个Button
            [btn setImage:[UIImage ml_imageFromBundleNamed:@"iconfont-tianjia"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(photoSelectet) forControlEvents:UIControlEventTouchUpInside];
        }else{
            // 如果是本地ZLPhotoAssets就从本地取，否则从网络取
            if ([[self.assets objectAtIndex:i-pictureCount] isKindOfClass:[ZLPhotoAssets class]])
            {
                [btn setImage:[self.assets[i-pictureCount] thumbImage] forState:UIControlStateNormal];
            }
            else if ([[self.assets objectAtIndex:i-pictureCount] isKindOfClass:[UIImage class]]){
                [btn setImage:self.assets[i-pictureCount] forState:UIControlStateNormal];
            }
            btn.tag = i+pictureCount;
            [btn addTarget:self action:@selector(bigimage) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        [self.scrollView addSubview:btn];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY([[self.scrollView.subviews lastObject] frame])+50);
}

#pragma mark - 选择图片
- (void)photoSelectet{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // MaxCount, Default = 9
    pickerVc.maxCount = 100;
    // Jump AssetsVc
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // Filter: PickerPhotoStatusAllVideoAndPhotos, PickerPhotoStatusVideos, PickerPhotoStatusPhotos.
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    // Recoder Select Assets
    pickerVc.selectPickers = self.assets;
    // Desc Show Photos, And Suppor Camera
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.isShowCamera = YES;
    // CallBack
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        self.assets = status.mutableCopy;
        [self reloadScrollView];
    };
    [pickerVc showPickerVc:self];
}
-(void)bigimage
{
    NSLog(@"sdg");
}
#pragma LoadData
-(void)loadData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *pra = [NSMutableDictionary dictionary];
    
    [mgr POST:@"http://139.196.34.170/familyweb/photo/familyphoto.php" parameters:pra progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *pictureArray = responseObject;
         CGFloat width = [UIScreen mainScreen].bounds.size.width/4-2;
    
        
        for(int i=0;i<pictureArray.count;i++)
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i%4*(width+2), i/4*(width+2), width, width)];
          
            SDWebImageManager *mag = [SDWebImageManager sharedManager];
            [mag downloadImageWithURL:[NSURL URLWithString:pictureArray[i]] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                imgView.image = image;
            }];
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i%4*(width+2), i/4*(width+2), width, width)];
            [btn setImage:imgView.image forState:UIControlStateNormal];
            
            btn.tag = i;
            [btn addTarget:self action:@selector(bigimage) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:btn];
            
        }
          pictureCount += pictureArray.count;
      
        NSLog(@"load%d",pictureCount);
        [self reloadScrollView];

    }
     
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"--%@",error);
          
      }];
  
}
@end
