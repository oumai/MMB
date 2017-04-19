//
//  ASUUID.m
//  AngelSound
//
//  Created by jumper on 15/10/8.
//  Copyright © 2015年 Jumper. All rights reserved.
//

#import "ASUUID.h"

#import "CBKeyChain.h"
@implementation ASUUID

+(NSString *)getUUID
{
    
    [CBKeyChain getKeychainQuery:@"965450544.com.jumper-medical.angeldoctor"];
    
    NSString *strUUID = [CBKeyChain load:@"965450544.com.jumper-medical.angeldoctor"];
    
    //首次执行该方法时，uuid为空
    if (!strUUID)
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        [CBKeyChain save:@"965450544.com.jumper-medical.angeldoctor" data:strUUID];
        
    }
    return strUUID;
}

@end
