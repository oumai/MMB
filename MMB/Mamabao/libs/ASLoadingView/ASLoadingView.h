//
//  ASLoadingView.h
//  AngelSound
//
//  Created by jumper on 15/7/13.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASLoadingView : NSObject
{
    UIView *backView;
}
/*显示加载*/
+(ASLoadingView *)show:(UIView *)view;

/*隐藏加载*/
+(void)hiden:(UIView *)view;

+(void)showActivity:(UIView *)view;

/**带有文字的**/
+(void)showActivity:(UIView *)view string:(NSString *)string;

+(void)hidenActivity:(UIView *)view;

+(void)showString:(NSString *)string andView:(UIView *)view;
@end
