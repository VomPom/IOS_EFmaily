//
//  AlbumViewController.h
//  Family
//
//  Created by Julis on 16/7/13.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumViewController : UIViewController
@property (nonatomic,retain,nonnull) UIBarButtonItem *rightItem;
@property (nonatomic, strong,nonnull) UITableView *imagetableView;
@property (nonatomic, strong,nonnull) UIImageView *imageView;
@property (nonatomic, strong,nonnull) UIImageView *headImageView;
@property (nonatomic, strong,nonnull) UIView *navigationView;
@property (nonatomic, strong,nonnull) UIButton *buttonBack;
@property (nonatomic, assign )CGFloat headerHeight;
@property (nonnull,strong) UILabel *nameLabel;
@end