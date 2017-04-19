//
//  ASDeviceActivity.h
//  AngelSound
//
//  Created by jumper on 14-11-12.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASNUll.h"

@interface ASDeviceActivity : NSObject

@property (assign)NSInteger backNumber; //返回id

@property (strong , nonatomic)NSString *deviceNumber ; //  设备号

@property (strong , nonatomic)NSString *deviceName ; //设备名称

- (void)saveMessageToLocation;

-(ASDeviceActivity *)getUserMessageFromLocation;

-(instancetype)initWithItem:(NSDictionary *)dict;

@end
