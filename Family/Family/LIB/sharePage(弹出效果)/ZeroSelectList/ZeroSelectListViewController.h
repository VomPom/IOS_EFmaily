//
//  SelectListViewController.h
//  SelectList
//
//  Created by ZWX on 16/6/15.
//  Copyright © 2016年 ZWX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZeroSelectListItem;

typedef void(^ZeroSelectListClickBlock)(NSInteger selectIndex);

@interface ZeroSelectListViewController : UIViewController

@property (nonatomic, strong) NSArray<ZeroSelectListItem *> * items;
@property (nonatomic, strong) UIViewController * showListViewControl;

@property (nonatomic, copy) ZeroSelectListClickBlock clickBlock;
//背景透明度
@property (nonatomic, assign) CGFloat alphaComponent;       //默认0.25

/**
 *  初始化
 *
 *  @param items 选项
 *
 *  @return return value description
 */
- (instancetype)initWithItems:(NSArray <ZeroSelectListItem *>*)items;


- (void)show;

- (void)dismissWithAnimate:(BOOL)animate;
@end
