//
//  ChooseStateVC.m
//  Login
//
//  Created by Michael on 15/11/6.
//  Copyright © 2015年 jumper. All rights reserved.
//

#import "ChooseStateVC.h"
#import "WYPopoverController.h"
#import "BirthVC.h"
#import "PregnancyVC.h"

#import "ASLoginInfomation.h"
#import "ASUUID.h"
@interface ChooseStateVC ()<WYPopoverControllerDelegate>

@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic , strong) WYPopoverController *simanPopoverController;
@property (strong, nonatomic) IBOutlet UILabel *pregnancyLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthLabel;

@end

@implementation ChooseStateVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}

- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择状态";
    NavigationBarTitleColor
    self.pregnancyLabel.textColor = KHexColor(@"#ffffff");
    self.birthLabel.textColor = KHexColor(@"#ff95a5");
    self.user = [[ASUserInfoModel alloc] init];
   
}

//怀孕
- (IBAction)pregnanceButtonClick:(UIButton *)sender {
    
    
    self.currentIdentity = @"0";
    PregnancyVC *pregnancy = [PregnancyVC new];                                     //初始化弹框
    pregnancy.preferredContentSize = CGSizeMake(CoreWidth,280); //350                    //设置弹框的大小
    
    [pregnancy setDismissSimanPopoverViewController:^(PregnancyVC *viewController) {
        [self.simanPopoverController dismissPopoverAnimated:YES completion:^{
            [self popoverControllerDidDismissPopover:_simanPopoverController];
        }];
    }];                                                                              //弹框消失。

    
    [pregnancy setPregnancyVCFinishBlock:^(PregnancyVC *pregnancyVC){
        
        if ([pregnancyVC.dateString isValid]) {
            self.dateString = pregnancyVC.dateString;
        }
        else{
            self.dateString = pregnancyVC.currentDate;
        }
        self.currentIdentity = pregnancy.currentIdentity;
        [self saveInformation];
    }];                                                                              //确定方法
    self.simanPopoverController = [[WYPopoverController alloc] initWithContentViewController:pregnancy];
    self.simanPopoverController.delegate = self;
    self.simanPopoverController.animationDuration = .5f;
    self.simanPopoverController.passthroughViews = @[sender];
    //self.simanPopoverController.popoverLayoutMargins = CoreWidth == 320 ? UIEdgeInsetsMake(400, 10,10, 10) : CoreWidth == 375 ? UIEdgeInsetsMake(667-328-40, 10,10,10) : UIEdgeInsetsMake(717-328-40, 10,10, 10);
    // self.simanPopoverController.popoverLayoutMargins = CoreWidth == 320 ? UIEdgeInsetsMake(40, 10,200, 10) : CoreWidth == 375 ? UIEdgeInsetsMake(40, 10,667-328-10,10) : UIEdgeInsetsMake(40, 10,717-328-10, 10);
    self.simanPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
    self.simanPopoverController.wantsDefaultContentAppearance = NO;
    
    
    WYPopoverTheme *result = [[WYPopoverTheme alloc] init];                         //设置弹框的主题风格
    result.usesRoundedArrow = YES;
    result.dimsBackgroundViewsTintColor = YES;
    result.tintColor = nil;
    result.outerStrokeColor = [UIColor clearColor];
    result.innerStrokeColor = [UIColor clearColor];
    result.fillTopColor = nil;
    result.fillBottomColor = nil;
    result.glossShadowColor = nil;
    result.glossShadowOffset = CGSizeZero;
    result.glossShadowBlurRadius = 0;
    result.borderWidth = 0;
    result.arrowBase = 15;
    result.arrowHeight = 6;
    result.outerShadowColor = [UIColor clearColor];
    result.outerShadowBlurRadius = 0;
    result.outerShadowOffset = CGSizeZero;
    result.outerCornerRadius = 5;
    result.minOuterCornerRadius = 0;
    result.innerShadowColor = [UIColor clearColor];
    result.innerShadowBlurRadius = 0;
    result.innerShadowOffset = CGSizeZero;
    result.innerCornerRadius = 0;
    result.viewContentInsets = UIEdgeInsetsZero;
    result.overlayColor = [UIColor colorWithWhite:0 alpha:0.3];
    result.preferredAlpha = 1.0f;
    self.simanPopoverController.theme = result;
    
    [_simanPopoverController presentPopoverAsDialogAnimated:YES
                                                    options:WYPopoverAnimationOptionFadeWithScale];
}

//已出生
- (IBAction)birthButtonClick:(UIButton *)sender {
    
    self.currentIdentity = @"1";
    BirthVC *simanPopoverViewController = [BirthVC new];                                        //初始化弹框
    simanPopoverViewController.preferredContentSize = CGSizeMake(CoreWidth,300);                //设置弹框的大小
   
    [simanPopoverViewController setDismissSimanPopoverViewController:^(BirthVC *viewController) {
        
        [self.simanPopoverController dismissPopoverAnimated:YES completion:^{
            [self popoverControllerDidDismissPopover:_simanPopoverController];
        }];
    }];                                                                                         //弹框消失。
    
    
    
    [simanPopoverViewController setSureBlock:^{
        
    }];                                                                                          //确定方法
    
    [simanPopoverViewController setBirthVCFinishBlock:^(BirthVC *birth) {
        
        if ([birth.dateString isValid]) {
            self.dateString = birth.dateString;
        }
        else{
            self.dateString = birth.currentDate;
        }
        self.sexString = birth.sexString;
        [self saveInformation];
    }];
    self.simanPopoverController = [[WYPopoverController alloc] initWithContentViewController:simanPopoverViewController];
    self.simanPopoverController.delegate = self;
    self.simanPopoverController.animationDuration = .5f;
    self.simanPopoverController.passthroughViews = @[sender];
    //self.simanPopoverController.popoverLayoutMargins = CoreWidth == 320 ? UIEdgeInsetsMake(240, 10,10, 10) : CoreWidth == 375 ? UIEdgeInsetsMake(667-328, 10,10,10) : UIEdgeInsetsMake(717-328, 10,10, 10);
    self.simanPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
    self.simanPopoverController.wantsDefaultContentAppearance = NO;
    
    
    WYPopoverTheme *result = [[WYPopoverTheme alloc] init];                                     //设置弹框的主题风格
    result.usesRoundedArrow = YES;
    result.dimsBackgroundViewsTintColor = YES;
    result.tintColor = nil;
    result.outerStrokeColor = [UIColor clearColor];
    result.innerStrokeColor = [UIColor clearColor];
    result.fillTopColor = nil;
    result.fillBottomColor = nil;
    result.glossShadowColor = nil;
    result.glossShadowOffset = CGSizeZero;
    result.glossShadowBlurRadius = 0;
    result.borderWidth = 0;
    result.arrowBase = 15;
    result.arrowHeight = 6;
    result.outerShadowColor = [UIColor clearColor];
    result.outerShadowBlurRadius = 0;
    result.outerShadowOffset = CGSizeZero;
    result.outerCornerRadius = 5;
    result.minOuterCornerRadius = 0;
    result.innerShadowColor = [UIColor clearColor];
    result.innerShadowBlurRadius = 0;
    result.innerShadowOffset = CGSizeZero;
    result.innerCornerRadius = 0;
    result.viewContentInsets = UIEdgeInsetsZero;
    result.overlayColor = [UIColor colorWithWhite:0 alpha:0.3];
    result.preferredAlpha = 1.0f;
    self.simanPopoverController.theme = result;
    [_simanPopoverController presentPopoverAsDialogAnimated:YES
                                                    options:WYPopoverAnimationOptionFadeWithScale];
}



#pragma mark - WYPopoverControllerDelegate
- (void)popoverControllerDidPresentPopover:(WYPopoverController *)controller
{
    NSLog(@"popoverControllerDidPresentPopover");
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    
    return YES;//点击其他地方，弹框消失
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    
    self.simanPopoverController.delegate = nil;
    NSLog(@"popoverControllerDidDismissPopover");
}

- (BOOL)popoverControllerShouldIgnoreKeyboardBounds:(WYPopoverController *)popoverController
{
    return YES;
}

- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value
{
    // keyboard is shown and the popover will be moved up by 163 pixels for example ( *value = 163 )
    *value = 0; // set value to 0 if you want to avoid the popover to be moved
}
#pragma mark ------------------------------------------------------  popoverActionsEnd--------------------------



- (void)saveInformation
{
    //本地存储
    NSUserDefaults *userDefDate = [NSUserDefaults standardUserDefaults];
    if ([self.dateString isValid])
    {
        
        NSString *sex= nil;
        
        [userDefDate setObject:self.dateString forKey:userBabyDate];
        if (self.babay_sex == 1)
        {
            [userDefDate setObject:@"女" forKey:userBabySex];
            sex = @"1";
        }else
        {
            [userDefDate setObject:@"男" forKey:userBabySex];
            sex = @"0";
        }
        
        [ASLoadingView showActivity:self.view];
        NSDictionary *jsonDic = @{@"mobile":self.phoneNumber,
                                  @"password":self.passwordNumber,
                                  @"verfied_code":self.codeNumber,
                                  @"device_ids":@""};
        [ASURLConnection requestAFNJSon:jsonDic method:kNRegister view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            [ASLoadingView  hidenActivity:self.view];
            
            if ([[ASURLConnection getMsg:responseObject]isEqual:@1])
            {
                ASUserInfoModel *user = [ASUserInfoModel objectWithKeyValues:AFNdata[0]];
                [user saveMessageToLocation];
                [self commitInfo];
                
            }else
            {
                k_NSlogHUD([ASURLConnection getMessage:responseObject])
            }
        } errorBlock:^(NSError *error) {
            [ASLoadingView  hidenActivity:self.view];
        }];
    }
    else
    {
        k_NSlogHUD(@"请选择宝宝生日")
    }
}

-(void)commitInfo{
    NSDictionary *json = nil;
    if ([self.currentIdentity  integerValue]== 0)   //怀孕
    {
        //知道预产期
        json = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                 @"statue":@0,
                 @"expect_date":self.dateString,
                 @"last_period":@"",
                 };
        
        
        
    }
    else  if ([self.currentIdentity integerValue]== 1)                            //辣妈
    {
        json = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                 @"statue":@1,
                 @"baby_birthday":self.dateString,
                 @"baby_sex":self.sexString,
                 };
    }
    
    
    else if ([self.currentIdentity integerValue]== 2)                  //不知道预产期
    {
        json = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                 @"statue":@0,
                 @"expect_date":@"",
                 @"last_period":self.dateString,};
        
    }
    
    
    [ASLoadingView showActivity:self.view];
    [ASURLConnection requestAFNJSon:json method:@"jumper.user.information.update" view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
        
        [ASLoadingView hidenActivity:self.view];
        
        if ([[ASURLConnection getMsg:responseObject]isEqual:@1]) {
            
            self.user = [ASUserInfoModel objectWithKeyValues:AFNdata[0]];
            self.user.isLogin = YES;
            [self.user saveMessageToLocation];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshDate" object:nil]; //修改预产期或者宝宝生日通知**/
            k_NSlogHUD([ASURLConnection getMessage:responseObject])
            
            double delayTime = 1.0;
            __block UIViewController *bself = self;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime *NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [bself.navigationController popViewControllerAnimated:YES];
            });
            [[NSNotificationCenter defaultCenter] postNotificationName:JumpWindow object:nil userInfo:nil]; //跳转到主页面
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject])
        }
    } errorBlock:^(NSError *error) {
        [ASLoadingView hidenActivity:self.view];
    }];
    
}/**正常注册**/
-(void)registerUser:(NSString *)date{
    
    [ASLoadingView showActivity:self.view];
    NSDictionary *json =  @{@"mobile":self.phoneNumber,
                            @"password":self.passwordNumber,
                            @"device_id":[ASUUID getUUID],
                            date:self.dateString,
                            @"mobile_type":@1,
                            @"current_identity":@0,};
    
    
    [ASURLConnection requestAFNJSon:json method:kNRegister view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject)
    {
        [ASLoadingView hidenActivity:self.view];
        
        if([[ASURLConnection getMsg:responseObject]isEqual:@1]){
            ASUserInfoModel *user = [ASUserInfoModel objectWithKeyValues:AFNdata[0]];
            user.isLogin = YES;
            [user saveMessageToLocation];
            
            //保存用户信息
            [self saveLogin];
            [self updateNoti:user];
            
            //[self push:user];
            //[self tabbar];
            
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject])
        }
    } errorBlock:^(NSError *error) {
        [ASLoadingView hidenActivity:self.view];
    }];
}


/**
 *  保存用户登录信息
 */
-(void)saveLogin{
    
    ASLoginInfomation *login= [[ASLoginInfomation alloc]init];
    //    login.loginType = @"Own";
    
    login.loginName = self.phoneNumber;
    
    //    login.remberpass = self.passwordNumber;
    
    [login saveMessageToLocation];
}


//通知
-(void)updateNoti:(id)model
{
    //发送通知给商城
    [[NSNotificationCenter defaultCenter]postNotificationName:@"shop" object:[NSString stringWithFormat:@"%ld",(long)[model getUserMessageFromLocation].userId]];
    //发送通知提示首页更换用户数据
    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateList" object:@"update"];
}


@end
