//
//  MyDetailModel.h
//  Mamabao
//
//  Created by Michael on 16/1/8.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDetailModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *created_time;
@property (nonatomic, strong) NSString *file_url;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *talker;
@property (nonatomic, assign)CGFloat cellHeight;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
