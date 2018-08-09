//
//  PicturePickerVC.h
//  Family
//
//  Created by Julis on 16/7/12.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicturePickerVC : UIViewController<UIActionSheetDelegate>
@property (nonatomic,strong) UIActionSheet *actionSheet;
@property (nonatomic,strong) UIAlertView *alertView;
@property (nonatomic, assign) id<UIActionSheetDelegate>delegate;

-(void) clickToChoose;
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
