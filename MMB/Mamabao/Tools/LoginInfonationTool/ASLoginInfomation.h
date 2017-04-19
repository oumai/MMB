//
//  ASLoginInfomation.h
//  AngelSound
//
//  Created by jumper on 15-1-16.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSUserDefaults+RMSaveCustomObject.h"
#import "ASNUll.h"
@interface ASLoginInfomation : NSObject

@property (strong,nonatomic) NSString *remberpass;

@property (strong,nonatomic) NSString *loginName;

@property (strong,nonatomic) NSString *loginType;//登录方式

@property (strong , nonatomic)NSString *open_id;

@property (strong , nonatomic)NSString *nick_name;

@property (strong , nonatomic)NSString *user_img;

@property (strong , nonatomic)NSString *user_type;

-(instancetype)initWithItem:(NSDictionary *)dict;

- (void)saveMessageToLocation;

-(ASLoginInfomation *)getUserMessageFromLocation;
@end
