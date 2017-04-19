//
//  ASDeviceActivity.m
//  AngelSound
//
//  Created by jumper on 14-11-12.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import "ASDeviceActivity.h"

#define keyDevice @"activity"
@implementation ASDeviceActivity

-(instancetype)initWithItem:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.backNumber   = [[ASNUll NSNullString:[dict objectForKey:@"id"]]intValue];
        self.deviceNumber = [ASNUll NSNullString:[dict objectForKey:@"device_no"]];
        self.deviceName   = [ASNUll NSNullString:[dict objectForKey:@"name"]];
    }
    return self;
}

// 保存信息到本地
- (void)saveMessageToLocation{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault rm_setCustomObject:self forKey:keyDevice];
}
/**
 *  从本地获取保存的用户信息
 *
 *  @return 返回的信息
 */
-(ASDeviceActivity *)getUserMessageFromLocation{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return ([userDefault rm_customObjectForKey:keyDevice]);
}

@end
