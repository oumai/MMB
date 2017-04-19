//
//  AddSugarDataVC.h
//  Mamabao
//
//  Created by Michael on 15/11/25.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSugarDataVC : UIViewController
@property (nonatomic, strong) void(^dismissSimanPopoverViewController)(AddSugarDataVC *);
@property (nonatomic, strong) void(^sureBlock)();
@end
