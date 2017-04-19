//
//  ConsultingChatPingJiaVC.h
//  Mamabao
//
//  Created by Michael on 15/11/16.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EvaTypeConsult = 0,
    EvaTypeOrder = 1
}EvaType;

@interface ConsultingChatPingJiaVC : UIViewController

@property (assign , nonatomic) EvaType type;
@property (assign , nonatomic) NSInteger detailId;

@end
