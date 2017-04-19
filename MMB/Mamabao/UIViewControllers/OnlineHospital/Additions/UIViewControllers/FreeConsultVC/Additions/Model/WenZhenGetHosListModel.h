//
//  WenZhenGetHosListModel.h
//  Mamabao
//
//  Created by Michael on 15/12/4.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WenZhenGetHosListModel : UIViewController

@property(nonatomic,strong)NSString *hospital_image;
@property(nonatomic,strong)NSString *hospital_name;
@property(nonatomic,strong)NSString *times;
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,assign)BOOL is_recommend;
@property(nonatomic,strong)NSNumber *money;
@property(nonatomic,strong)NSNumber *nums;
@property (assign) BOOL is_free;
@property (assign) BOOL is_user;

@end
