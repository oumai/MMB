//
//  OtherDetailCell.h
//  Mamabao
//
//  Created by Michael on 16/1/11.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDetailModel.h"

@interface OtherDetailCell : UITableViewCell

@property (nonatomic, strong) MyDetailModel *detail;

+ (CGFloat)heightForRowWithStringleftDetail:(NSString *)string;

@end
