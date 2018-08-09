//
//  SuggestionsViewController.m
//  Family
//
//  Created by Julis on 16/7/13.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "SuggestionsViewController.h"
#define WidthW [UIScreen mainScreen].bounds.size.width
@interface SuggestionsViewController ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    int index;
}
@property (nonatomic,assign) int alphaNumber;
@property (nonatomic,strong) UILabel *alphaNumberLabel;


@end

@implementation SuggestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [self Navigation];
    [self UItextview];
    [self layout];
    [self pictureView];
    [self addPictureBtnSet];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)UItextview
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.scrollEnabled = NO;
    self.view.backgroundColor=HCColor(240, 240, 240);
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0,84, WidthW, 100)];
    self.textView.backgroundColor=[UIColor whiteColor];
    self.textView.delegate=self;
    self.textView.text=@"请简要描述您的问题和意见";
    self.textView.textColor=[UIColor lightGrayColor];//设置提示文字
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.font = [UIFont systemFontOfSize:20.0f];
    //设置字数按钮
    _alphaNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthW-35, 160, 40, 20)];
    
    [self.view addSubview:_textView];
    [self.view addSubview:_alphaNumberLabel];
   
}
-(void)layout
{
    UILabel *pointTitle  = [[UILabel alloc]initWithFrame:CGRectMake(0, 184, WidthW, 45)];
    pointTitle.textColor = HCColor(100, 100, 100);
    pointTitle.text=@"  图片 (可提供问题截图)";
    [self.view addSubview:pointTitle];
}
-(void)pictureView
{
    UIView *picView = [[UIView alloc]initWithFrame:CGRectMake(0, 229, WidthW, 100)];
    picView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:picView];
}
-(void)addPictureBtnSet
{
    
    UIButton *addPictureBtn = [[UIButton alloc]initWithFrame:CGRectMake(80*index+10, 239, 80, 80)];
    [addPictureBtn setImage:[UIImage imageNamed:@"btn_addPicture"] forState:UIControlStateNormal];
    
    
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(80*index+10, 234, 90, 90)];
    [self.view addSubview:_imageView];
    
    //[addPictureBtn addTarget:self action:@selector(clickToChoose) forControlEvents:UIControlEventTouchDown];
    
    [addPictureBtn addTarget:self action:@selector(clickToChoose) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:addPictureBtn];
     ++index;
    
}
-(void)Navigation
{
    [self.navigationItem setTitle:@"意见反馈"];
    _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName]=[UIColor colorWithRed:49/255.0 green:194/255.0 blue:125/255.0 alpha:1];
    [_rightItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=_rightItem;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _alphaNumber=300-(int)[_textView.text length];
    _alphaNumberLabel.text=[NSString stringWithFormat:@"%d",_alphaNumber];
    
    
}
- (void)textViewDidChange:(UITextView *)textView;
{
    _alphaNumber=300-(int)[textView.text length];
    NSLog(@"%d",_alphaNumber);
    if([textView.text length]==0||_alphaNumber<0)
    {
        self.rightItem.enabled=NO;
        if([textView.text length]==0)
            _alphaNumberLabel.textColor=[UIColor lightGrayColor];
        else
        _alphaNumberLabel.textColor=[UIColor redColor];
        
    }
    else
    {
        self.rightItem.enabled=YES;
        _alphaNumberLabel.textColor=[UIColor lightGrayColor];
    }
    _alphaNumberLabel.text=[NSString stringWithFormat:@"%d",_alphaNumber];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=330)
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







-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
            
        default:
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
    _imageView.layer.cornerRadius = 32;
    _imageView.layer.masksToBounds = YES;
    [_imageView setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //
    //    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];//如果按钮创建时用的是系统风格UIButtonTypeSystem，需要在设置图片一栏设置渲染模式为"使用原图"
    
    
    
    //    button.layer.cornerRadius = 10;
    //    button.layer.masksToBounds = YES;
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}


@end
