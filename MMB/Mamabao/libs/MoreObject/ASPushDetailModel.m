//
//  ASPushDetailModel.m
//  AngelSound
//
//  Created by jumper on 15-1-17.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASPushDetailModel.h"

@implementation ASPushDetailModel
-(instancetype)initWithItem:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.pushID = [[ASNUll NSNullString:[dict objectForKey:@"id"]]integerValue];
        self.content   = [ASNUll NSNullString:[dict objectForKey:@"content"]];
        self.time = [ASNUll NSNullString:[dict objectForKey:@"push_time"]];
        self.title   = [ASNUll NSNullString:[dict objectForKey:@"title"]];
        self.type = [[ASNUll NSNullString:[dict objectForKey:@"type"]]integerValue];
    }
    return self;
}
@end
