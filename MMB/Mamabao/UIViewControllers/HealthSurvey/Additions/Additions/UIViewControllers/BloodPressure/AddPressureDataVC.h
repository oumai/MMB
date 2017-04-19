//
//  AddPressureDataVC.h
//  Mamabao
//
//  Created by Michael on 15/11/25.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPressureDataVC : UIViewController
@property (nonatomic, strong) void(^dismissSimanPopoverViewController)(AddPressureDataVC *);
@property (nonatomic, strong) void(^sureBlock)();
@end
