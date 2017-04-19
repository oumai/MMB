//
//  ASNUll.m
//  AngelSound
//
//  Created by jumper on 15-1-16.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASNUll.h"

@implementation ASNUll
+ (NSString *)NSNullString:(id)object {
    if ((NSNull *) object == [NSNull null] || object == nil) {
        return @"";
    }
    else {
        return [NSString stringWithFormat:@"%@", object] ;
    }
}
@end
