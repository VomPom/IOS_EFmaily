//
//  sendPhotosViewController.m
//  Family
//
//  Created by Julis on 16/7/17.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "sendPhotosViewController.h"
#import "ZLPhotoActionSheet.h"
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface sendPhotosViewController ()<UITextViewDelegate>
{
    ZLPhotoActionSheet *actionSheet;
    int pictureCount;
}
@property (nonatomic , strong) NSMutableArray *assets;
@property (nonatomic,assign) int alphaNumber;
@property (nonatomic,strong) UILabel *alphaNumberLabel;
@property (nonatomic,strong) UITextView *textView;
@end

@implementation sendPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self photoSelectet];
    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 20;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    [self Navigation];
    [self freamWorkSet];
   
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    //pickerVc.selectPickers = self.assets;
    // Desc Show Photos, And Suppor Camera
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.isShowCamera = YES;
    // CallBack
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        self.assets = status.mutableCopy;
        //[self reloadScrollView];
    };
    [pickerVc showPickerVc:self];
}

-(void)freamWorkSet
{
    UIView *photsoBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENWIDTH/8)];
    photsoBgView.backgroundColor = [UIColor whiteColor];
    
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, SCREENWIDTH/8+64+10, SCREENWIDTH, 160)];
    self.textView.delegate=self;
    self.textView.text=@"说点什么吧～";
    self.textView.textColor=[UIColor lightGrayColor];//设置提示文字
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.font = [UIFont systemFontOfSize:20.0f];
    UIButton *addLocationBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREENWIDTH/8+64+10+160+20, SCREENWIDTH/3-20, 30)];
    addLocationBtn.backgroundColor = [UIColor whiteColor];
    addLocationBtn.layer.cornerRadius = 15;
    addLocationBtn.clipsToBounds=YES;
    [addLocationBtn setTitle:@"添加位置" forState:UIControlStateNormal];
    [addLocationBtn setTitleColor:[UIColor colorWithRed:0.2157 green:0.2118 blue:0.298 alpha:1.0] forState:UIControlStateNormal];
    
    _alphaNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-35, 260, 40, 20)];
  //  addLocationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addLocationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 00);
//    [addLocationBtn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
//    [addLocationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, SCREENWIDTH/3-30)];
    [self.view addSubview:photsoBgView];
    [self.view addSubview:self.textView];
    [self.view addSubview:addLocationBtn];
    [self.view addSubview:_alphaNumberLabel];
    
}
-(void)Navigation
{
    self.view.backgroundColor = [UIColor colorWithRed:0.9137 green:0.9137 blue:0.9137 alpha:1.0];
   // self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.1098 green:0.1059 blue:0.1294 alpha:1.0];
    [self.navigationItem setTitle:@"发照片"];
}

#pragma textView

//设置字数按钮




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _alphaNumber=150-(int)[_textView.text length];
    _alphaNumberLabel.text=[NSString stringWithFormat:@"%d",_alphaNumber];
    
}
- (void)textViewDidChange:(UITextView *)textView;
{
    _alphaNumber=150-(int)[textView.text length];
    if([textView.text length]==0||_alphaNumber<0)
    {
        if([textView.text length]==0)
            _alphaNumberLabel.textColor=[UIColor lightGrayColor];
        else
            _alphaNumberLabel.textColor=[UIColor redColor];
        
    }
    else
    {
        _alphaNumberLabel.textColor=[UIColor lightGrayColor];
    }
    _alphaNumberLabel.text=[NSString stringWithFormat:@"%d",_alphaNumber];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=170)
    {
        return  NO;
    }
    else
    {
        return YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textView.text=@"";
    self.textView.textColor=[UIColor blackColor];
}


@end
