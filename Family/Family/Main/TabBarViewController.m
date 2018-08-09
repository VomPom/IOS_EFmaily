//
//  TabBarViewController.m
//  微享圈
//
//  Created by Mac on 15/12/3.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavigationViewController.h"
#import "IndexRelativeViewController.h"
#import "IndexPhotographViewController.h"
#import "IndexMineViewController.h"
#import "FirstLoginController.h"
#import "IndexRelationshipTableViewController.h"
#import "shareTableViewController.h"
@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    
    // 1.初始化子控制器
    //FirstLoginController *home = [[FirstLoginController alloc] init];
    shareTableViewController  *home = [[shareTableViewController alloc] init];
    [self addChildVc:home title:@"分享" image:@"btn_shouye" selectedImage:@"btn_shouyelight"];


    IndexPhotographViewController *discover = [[IndexPhotographViewController alloc] init];
    [self addChildVc:discover title:@"家庭相册" image:@"icon_photograph" selectedImage:@"btn_darenlight"];

    
    IndexRelationshipTableViewController *found = [[IndexRelationshipTableViewController alloc] init];
    [self addChildVc:found title:@"亲友" image:@"btn_qingyou" selectedImage:@"btn_qingyoulight"];

    
    IndexRelativeViewController *profile = [[IndexRelativeViewController alloc] init];
    [self addChildVc:profile title:@"亲友圈" image:@"btn_qingyouquan" selectedImage:@"btn_wodelight"];

    
    IndexMineViewController *mine = [[IndexMineViewController alloc] init];
    [self addChildVc:mine title:@"我的" image:@"btn_mine" selectedImage:@"btn_wodelight"];

    
   
   

}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
//    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式92183155
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIFont systemFontOfSize:20];
//    textAttrs[NSForegroundColorAttributeName] = HCColor(200, 85, 85);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = HCColor(92, 183, 155);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    childVc.view.backgroundColor = HCRandomColor;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}



@end
