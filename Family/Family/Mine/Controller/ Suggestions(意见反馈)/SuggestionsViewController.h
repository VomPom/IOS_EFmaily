//
//  SuggestionsViewController.h
//  Family
//
//  Created by Julis on 16/7/13.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestionsViewController : UIViewController
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIBarButtonItem *rightItem;
@property (nonatomic,strong) UIActionSheet *actionSheet;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,weak) UIButton *addPictureBtn;
@end
