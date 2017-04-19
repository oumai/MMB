//
//  PregnancyVC.h
//  Mamabao
//
//  Created by Michael on 15/11/19.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PregnancyVC : UIViewController

@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *currentDate;
@property (nonatomic, strong) NSString *currentIdentity;
@property (nonatomic, strong) void(^dismissSimanPopoverViewController)(PregnancyVC *);
@property (nonatomic, strong) void(^pregnancyVCFinishBlock)(PregnancyVC *);
@end
