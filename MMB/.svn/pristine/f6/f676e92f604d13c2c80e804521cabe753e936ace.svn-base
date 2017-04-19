//
//  ASLoginInfomation.m
//  AngelSound
//
//  Created by jumper on 15-1-16.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASLoginInfomation.h"

@implementation ASLoginInfomation

#define keyUserMessages @"login"

-(instancetype)initWithItem:(NSDictionary *)dict{
    self = [super init];
    if (self) {

    }
    return self;
}
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
-(ASLoginInfomation *)getUserMessageFromLocation{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return ([userDefault rm_customObjectForKey:keyUserMessages]);
}
@end
