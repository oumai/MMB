//
//  KeYuYueTimeVC.h
//  Mamabao
//
//  Created by Michael on 15/12/14.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeYuYueTimeVC : UIViewController
@property (nonatomic, strong) void(^dismissSimanPopoverViewController)(KeYuYueTimeVC *);
@property (nonatomic, strong) void(^sureBlock)(NSString *);
@end
