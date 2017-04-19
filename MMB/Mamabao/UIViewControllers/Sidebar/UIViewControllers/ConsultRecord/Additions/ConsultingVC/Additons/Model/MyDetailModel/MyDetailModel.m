//
//  MyDetailModel.m
//  Mamabao
//
//  Created by Michael on 16/1/8.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "MyDetailModel.h"

@implementation MyDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"content"]) {
            self.content = [dic objectForKey:@"content"];
        }
        if ([dic objectForKey:@"file_url"]) {
            self.file_url = [dic objectForKey:@"file_url"];
        }
        if ([dic objectForKey:@"created_time"]) {
            self.created_time = [dic objectForKey:@"created_time"];
        }
        if ([dic objectForKey:@"created_time"]) {
            self.created_time = [dic objectForKey:@"created_time"];
        }
        if ([[dic objectForKey:@"talker"] isKindOfClass:[NSNumber class]] ) {
            self.talker = [[dic objectForKey:@"talker"] stringValue];
        }
    }
    return self;
}

@end
