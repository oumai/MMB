//
//  ASNotificationStatus.h
//  AngelSound
//
//  Created by jumper on 14-10-17.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASNotificationStatus : NSObject

@property (assign)NSInteger status; //1为开，0为关

- (void)saveMessageToLocation;

-(ASNotificationStatus *)getUserMessageFromLocation;
@end
