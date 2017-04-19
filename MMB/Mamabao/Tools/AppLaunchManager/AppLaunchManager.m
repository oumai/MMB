//
//  AppLaunchManager.m
//  Mamabao
//
//  Created by Michael on 16/1/11.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "AppLaunchManager.h"
#import "HealthSurveyVC.h"
#import "OnlineHospitalVC.h"
#import "MamiServicesVC.h"
#import "PregnancyMotherChurchVC.h"
#import "SidebarViewController.h"
#import "LoginVC.h"
@interface AppLaunchManager ()

@property (nonatomic, strong) UINavigationController *navMenu;
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) UIWindow *window;
@end

@implementation AppLaunchManager

+ (AppLaunchManager *)sharedManager {
    
    

    static AppLaunchManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)launch {
    
    //设置引导页的方法
    BOOL canShow = [CoreNewFeatureVC canShowNewFeature];
    
    if (canShow) {
        //有几张图片就设置几张主页
        NewFeatureModel *m1 = [NewFeatureModel model:[UIImage imageNamed:@"yinDao1"]];
        NewFeatureModel *m2 = [NewFeatureModel model:[UIImage imageNamed:@"yinDao2"]];
        NewFeatureModel *m3 = [NewFeatureModel model:[UIImage imageNamed:@"yinDao3"]];
        
        CoreNewFeatureVC *coreNewFearureVC = [CoreNewFeatureVC newFeatureVCWithModels:@[m1 , m2 , m3 ] enterBlock:^{
            
            ZYMenuController *menuController = self.menuController;
            if (self.launchRootViewControllerWithTabbarController)
            {
                self.launchRootViewControllerWithTabbarController(menuController);
            }
        }];
        
        if (self.lauchingRootViewControllerWithCoreNewFeature) {
            self.lauchingRootViewControllerWithCoreNewFeature(coreNewFearureVC);
        }
        return;
    }

    
    
    
    ZYMenuController *menuController = self.menuController;
    if (self.launchRootViewControllerWithTabbarController)
    {
        self.launchRootViewControllerWithTabbarController(menuController);
    }
}

- (ZYMenuController *)menuController {
    
    if (nil == _menuController) {
        
        SidebarViewController *left = [[SidebarViewController alloc]init];
        UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:left];
        
        HealthSurveyVC *vvc = [HealthSurveyVC new];
        vvc.title = @"健康监测";
        vvc.tabBarItem.image = [UIImage imageNamed:@"2-7-bottombar"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vvc];
        
        OnlineHospitalVC *svvc = [OnlineHospitalVC new];
        svvc.title = @"在线医院";
        svvc.tabBarItem.image = [UIImage imageNamed:@"2-1-bottombar"];
        UINavigationController *snav = [[UINavigationController alloc] initWithRootViewController:svvc];
        
        MamiServicesVC *tvvc = [MamiServicesVC new];
        tvvc.title = @"妈咪服务";
        tvvc.tabBarItem.image = [UIImage imageNamed:@"2-3-bottombar"];
        UINavigationController *tnav = [[UINavigationController alloc] initWithRootViewController:tvvc];
        
        PregnancyMotherChurchVC *fvvc = [PregnancyMotherChurchVC new];
        fvvc.title = @"孕妈堂";
        fvvc.tabBarItem.image = [UIImage imageNamed:@"2-5-bottombar"];
        UINavigationController *fnav = [[UINavigationController alloc] initWithRootViewController:fvvc];
        
        UITabBarController *tabBarV = [[UITabBarController alloc] init];
        tabBarV.tabBar.tintColor = KHexColor(@"#ff5873");
        tabBarV.viewControllers = @[fnav,nav,snav,tnav];
        
        self.window = [UIApplication sharedApplication].delegate.window;
        self.menuController = [[ZYMenuController alloc] initWithRootViewController:tabBarV leftViewController:leftNav rightViewController:nil];
        self.menuController.transitionStyle = ZYTransitionStyleQQ;//设置动画的方式
        self.navMenu = [[UINavigationController alloc] initWithRootViewController:_menuController];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainWindowClick) name:JumpWindow object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginZhuXiao) name:Zhuxiaodenglu object:nil];
        
    }
    return _menuController;
}

- (void)loginAndWindow
{
    
}
- (void)mainWindowClick
{
    self.window.rootViewController = _navMenu;
}

- (void)loginZhuXiao
{
    self.user = [[ASUserInfoModel alloc] init];
    LoginVC *login = [LoginVC new];
    [self.user getUserMessageFromLocation].isLogin = NO;
    [self.user saveMessageToLocation];
    self.window.rootViewController = login;
    
    
}


@end
