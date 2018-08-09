//
//  UINavigationBar+ST.h
//  STNavigationBar
//
//  Created by liuzhen on 16/5/3.
//  Copyright © 2016年 liuzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ST)
- (void)st_setBackgroundColor:(UIColor *)backgroundColor;
- (void)st_setElementsAlpha:(CGFloat)alpha;
- (void)st_setTranslationY:(CGFloat)translationY;
- (void)st_reset;
@end
