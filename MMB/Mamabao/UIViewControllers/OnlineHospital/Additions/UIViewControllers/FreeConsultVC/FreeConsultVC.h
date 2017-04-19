//
//  FreeConsultVC.h
//  Mamabao
//
//  Created by Michael on 15/11/10.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeConsultVC : UIViewController
typedef enum
{
    payTypeFree = 0,
    payTypeConsult = 1,
    payTypeFamily =2,
    payTypeYiZhen = 3
}
payType;

@property (assign ,nonatomic)payType payType;
@property (assign ,nonatomic)NSInteger majorId;//科室ID
@property (strong ,nonatomic)NSString *doctorId;//医生ID
@property (strong , nonatomic)NSString *groupID;//咨询ID号(可为空：继续咨询的时候为咨询的ID，不继续咨询责不填写)

@end
