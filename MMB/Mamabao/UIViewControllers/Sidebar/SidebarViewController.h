//
//  SidebarViewController.h
//  Benevolence
//
//  Created by Michael on 15/10/27.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarViewController : UIViewController

@property (nonatomic, strong) void(^backAndPush)(UIButton *);

@end
