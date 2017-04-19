//
//  ChooseStateVC.h
//  Login
//
//  Created by Michael on 15/11/6.
//  Copyright © 2015年 jumper. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , ASRegisterRole)
{
    ASRegisterRolePregnancy = 0,
    ASRegisterRoleMom = 1
};

typedef NS_ENUM(NSInteger , ASRegisterSource)
{
    ASRegisterSourcePhone = 0,
    ASRegisterSourceOther
};

typedef NS_ENUM(NSInteger , ASRegisterNet)
{
    ASRegisterNetYES = 0,   
    ASRegisterNetNO,
};

@interface ChooseStateVC : UIViewController

@property (nonatomic, strong) NSString *currentDate;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *sexString;

@property (nonatomic, assign)NSInteger babay_sex;       //男孩与女孩
@property (assign) ASRegisterNet net;                   //是否走网络请求
@property (assign) ASRegisterRole role;                 //怀孕与辣妈
@property (assign) ASRegisterSource source;             //来源
@property (strong , nonatomic)NSString *phoneNumber;    //电话号码
@property (strong , nonatomic)NSString *passwordNumber; //密码
@property (strong , nonatomic)NSString *codeNumber;     //验证码
@property (assign)BOOL isNet;                           //是否走网络请求
@property (nonatomic, strong) NSString *currentIdentity;//1辣妈 0孕妈

@end
