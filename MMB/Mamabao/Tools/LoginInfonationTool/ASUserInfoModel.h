//
//  ASUserInfoModel.h
//  AngelSound
//
//  Created by jumper on 15-1-16.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSUserDefaults+RMSaveCustomObject.h"
typedef  NS_ENUM(NSInteger , ASChoiceSource){
    ASChoiceSourceAngelHospital,/**天使医院**/
    ASChoiceSourceOtherHospital/**其他医院**/
};

typedef  NS_ENUM(NSInteger , ASAreaSource){
    ASAreaSourceChangeHospital,
    ASAreaSourceBindHospital,
    ASAreaSourceChoiceDoctor,
    ASAreaSourceOther
};

#import "ASNUll.h"

@interface ASUserInfoModel : NSObject

@property (assign) BOOL isLogin;

@property (assign,nonatomic) NSInteger userId; //用户ID

@property (strong,nonatomic) NSString *userMobile; //用户电话

@property (strong,nonatomic) NSString *email;//用户email

@property (strong,nonatomic) NSString *userNickname; //用户昵称

@property (strong,nonatomic) NSString *userImg; // 用户头像

@property (assign,nonatomic) NSInteger userProviceId; //用户省份ID

@property (assign,nonatomic) NSInteger userCityId; //用户城市ID；

@property (strong,nonatomic) NSString *userProviceName; //用户省份

@property (strong,nonatomic) NSString *userCityName; //用户城市

@property (assign,nonatomic) NSInteger userStatus; // 用户状态  //怀孕与已有宝宝状态status

@property (assign,nonatomic) NSInteger userPushStatus; // 用户推送信息开关

@property (strong,nonatomic) NSString *userExpectConfindent;  //用户预产期

@property (assign,nonatomic) NSInteger userExpectedWeek; //孕几周

@property (assign,nonatomic) NSInteger userExpectedDays; //还剩几天

@property (assign, nonatomic)NSInteger expected_day;

@property (strong , nonatomic)NSString * useridentityCard;//用户身份证

@property (strong , nonatomic)NSString *userRealName;//用户真实姓名

@property (assign)NSInteger userAge;//用户年龄

@property (strong , nonatomic)NSString *contactPhone;//联系电话

@property (strong , nonatomic)NSString *height;//身高

@property (strong , nonatomic)NSString *weight;//体重

@property (assign)NSInteger gold;//金币

@property (strong , nonatomic)NSString *hospitalName;//用户医院

@property (assign)NSInteger currentIdentity;            //怀孕与已有宝宝状态status

//@property (assign)NSInteger status;

@property (strong , nonatomic)NSString *baby_birthday;

@property (assign)NSInteger baby_sex;

@property (assign)NSInteger hospitalId;


-(instancetype)initWithItem:(NSDictionary *)dict;

- (void)saveMessageToLocation;

/**
 *  从本地获取保存的用户信息
 *
 *  @return 返回用户的信息
 */
-(ASUserInfoModel *)getUserMessageFromLocation;
@end
