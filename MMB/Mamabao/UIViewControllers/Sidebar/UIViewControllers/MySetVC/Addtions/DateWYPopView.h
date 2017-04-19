//
//  DateWYPopView.h
//  Mamabao
//
//  Created by Michael on 15/12/10.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateWYPopView : UIViewController

@property (nonatomic, strong) NSString *currentIdentity;
@property (nonatomic, assign) BOOL isKnow;     //知不知道预产期
@property (nonatomic, strong) void(^noYuChanQiBlock)(DateWYPopView *);
@property (nonatomic, strong) void(^dismissSimanPopoverViewController)(DateWYPopView *);
@property (nonatomic, strong) void(^sureBlock)(NSString *);
@end
