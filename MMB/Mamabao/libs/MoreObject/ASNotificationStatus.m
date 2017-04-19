//
//  ASNotificationStatus.m
//  AngelSound
//
//  Created by jumper on 14-10-17.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import "ASNotificationStatus.h"
#define keyUserMessages @"notiStatus"
@implementation ASNotificationStatus
// 保存信息到本地
- (void)saveMessageToLocation{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault rm_setCustomObject:self forKey:keyUserMessages];
}
/**
 *  从本地获取保存的用户信息
 *
 *  @return 返回的信息
 */
-(ASNotificationStatus *)getUserMessageFromLocation{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return ([userDefault rm_customObjectForKey:keyUserMessages]);
}

@end
