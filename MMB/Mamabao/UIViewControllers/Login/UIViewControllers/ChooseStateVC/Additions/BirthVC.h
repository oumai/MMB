//
//  BirthVC.h
//  Mamabao
//
//  Created by Michael on 15/11/19.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthVC : UIViewController

@property (nonatomic, strong) NSString *sexString;
@property (nonatomic, strong) NSString *currentDate;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) void(^dismissSimanPopoverViewController)(BirthVC *);
@property (nonatomic, strong) void(^birthVCFinishBlock)(BirthVC *);
@property (nonatomic, strong) void(^sureBlock)();
@end
