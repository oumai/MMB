//
//  ASPushDetailModel.h
//  AngelSound
//
//  Created by jumper on 15-1-17.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASNUll.h"
@interface ASPushDetailModel : NSObject

@property (assign)NSInteger pushID; //推送ID

@property (strong , nonatomic)NSString *content; // 推送信息

@property (strong , nonatomic)NSString *title; //推送标题

@property (strong , nonatomic)NSString *time; // 推送时间

@property (assign)NSInteger type;

-(instancetype)initWithItem:(NSDictionary *)dict;
@end
