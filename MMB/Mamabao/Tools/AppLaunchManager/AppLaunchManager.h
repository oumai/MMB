//
//  AppLaunchManager.h
//  Mamabao
//
//  Created by Michael on 16/1/11.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYMenuController.h"
#import "CoreNewFeatureVC.h"
@interface AppLaunchManager : NSObject


+ (AppLaunchManager *)sharedManager;

@property (nonatomic , strong) ZYMenuController *menuController;

@property (nonatomic, copy, readwrite) void (^launchRootViewControllerWithTabbarController)(ZYMenuController *menuController);
@property (nonatomic, strong) void(^lauchingRootViewControllerWithCoreNewFeature)(CoreNewFeatureVC *coreNewFearureVC);

- (void)launch;

@end
