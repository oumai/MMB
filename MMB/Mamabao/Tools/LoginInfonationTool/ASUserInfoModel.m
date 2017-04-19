//
//  ASUserInfoModel.m
//  AngelSound
//
//  Created by jumper on 15-1-16.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASUserInfoModel.h"

@implementation ASUserInfoModel

static ASUserInfoModel *shareUser;

#define keyUserMessages @"userMessages"

-(instancetype)initWithItem:(NSDictionary *)dict{
    self = [super init];
    if (self)
    {
        self.isLogin              = YES;
        self.userId               = [[ASNUll NSNullString:[dict objectForKey:@"id"]] intValue];
        self.userMobile           = [ASNUll NSNullString:[dict objectForKey:@"mobile"]];
        self.userNickname         = [ASNUll NSNullString:[dict objectForKey:@"nick_name"]];
        self.userImg              = [ASNUll NSNullString:[dict objectForKey:@"user_img"]];
        self.userProviceId        = [[ASNUll NSNullString:[dict objectForKey:@"province"]]intValue];
        self.userCityId           = [[ASNUll NSNullString:[dict objectForKey:@"city"]]intValue];
        self.userProviceName      = [ASNUll NSNullString:[dict objectForKey:@"provice_name"]];
        self.userCityName         = [ASNUll NSNullString:[dict objectForKey:@"city_name"]];
        self.userStatus           = [[ASNUll NSNullString:[dict objectForKey:@"status"]]intValue];
        self.userPushStatus       = [[ASNUll NSNullString:[dict objectForKey:@"switch_push_msg"]]intValue];
        self.userExpectConfindent = [ASNUll NSNullString:[dict objectForKey:@"expected_confinement"]];
        self.userExpectedWeek     = [[ASNUll NSNullString:[dict objectForKey:@"expected_week"]]intValue];
        self.userExpectedDays     = [[ASNUll NSNullString:[dict objectForKey:@"expected_days"]]intValue];
        self.useridentityCard     = [ASNUll NSNullString:[dict objectForKey:@"identification"]];
        self.userRealName         = [ASNUll NSNullString:[dict objectForKey:@"realname"]];
        self.userAge              = [[ASNUll NSNullString:[dict objectForKey:@"age"]] intValue];
        self.contactPhone         = [ASNUll NSNullString:[dict objectForKey:@"contactPhone"]];
        self.height               = [ASNUll NSNullString:[dict objectForKey:@"height"]];
        self.weight               = [ASNUll NSNullString:[dict objectForKey:@"weight"]];
    }
    return self;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"userId" : @"id",
             @"userMobile" : @"mobile",
             @"userNickname" : @"nick_name",
             @"userImg" : @"user_img",
             @"userProviceId" : @"province",
             @"userCityId" : @"city",
             @"userProviceName" : @"provice_name",
             @"userCityName" : @"city_name",
             @"userStatus" : @"status",
             @"userPushStatus" : @"switch_push_msg",
             @"userExpectConfindent" : @"expected_confinement",
             @"userExpectedWeek" : @"expected_week",
             @"userExpectedDays" : @"expected_days",
             @"useridentityCard" : @"identification",
             @"userRealName" : @"realname",
             @"userAge" : @"age",
             };
}

// 保存用户所有信息到本地
- (void)saveMessageToLocation
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault synchronize];
    [userDefault rm_setCustomObject:self forKey:keyUserMessages];
}
/**
 *  从本地获取保存的用户信息
 *
 *  @return 返回用户的信息
 */
-(ASUserInfoModel *)getUserMessageFromLocation
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault synchronize];
    return ([userDefault rm_customObjectForKey:keyUserMessages]);
}

@end
