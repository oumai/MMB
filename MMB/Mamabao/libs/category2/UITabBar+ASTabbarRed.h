//
//  UITabBar+ASTabbarRed.h
//  AngelSound
//
//  Created by jumper on 15/11/11.
//  Copyright © 2015年 Jumper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (ASTabbarRed)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
