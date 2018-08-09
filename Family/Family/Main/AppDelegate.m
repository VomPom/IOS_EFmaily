//
//  AppDelegate.m
//  Traveling
//
//  Created by ZHC on 16/5/16.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    TabBarViewController *tbVC = [[TabBarViewController alloc]init];
    self.window.rootViewController = tbVC;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

@end
