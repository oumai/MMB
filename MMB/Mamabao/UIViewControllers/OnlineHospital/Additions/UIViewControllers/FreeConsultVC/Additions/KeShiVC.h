//
//  KeShiVC.h
//  Mamabao
//
//  Created by Michael on 15/12/3.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeShiVC : UIViewController
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *major_id;
@property (nonatomic, strong) void(^dismissSimanPopoverViewController)(KeShiVC *);
@property (nonatomic, strong) void(^sureBlock)(KeShiVC *);
@end
