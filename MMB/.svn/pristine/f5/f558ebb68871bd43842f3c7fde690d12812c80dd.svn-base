//
//  ASVersionModel.m
//  AngelSound
//
//  Created by jumper on 15-1-16.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASVersionModel.h"

@implementation ASVersionModel
-(instancetype)initWithItem:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.apptype          = [[ASNUll NSNullString:[dict objectForKey:@"appType"]]intValue];
        self.downloadUrl      = [ASNUll NSNullString:[dict objectForKey:@"downloadUrl"]];
        self.updateInfomation = [ASNUll NSNullString:[dict objectForKey:@"remark"]];
        self.versionNumber    = [ASNUll NSNullString:[dict objectForKey:@"versionNo"]];
        self.versionName      = [ASNUll NSNullString:[dict objectForKey:@"versionName"]];
    }
    return self;
}

@end
