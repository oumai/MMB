//
//  MyDetailCell.h
//  Mamabao
//
//  Created by Michael on 16/1/8.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDetailModel.h"
@interface MyDetailCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconRightImage;
@property (nonatomic, strong) MyDetailModel *detail;
+ (CGFloat)heightForRowWithStringrightDetail:(NSString *)string;

@end
