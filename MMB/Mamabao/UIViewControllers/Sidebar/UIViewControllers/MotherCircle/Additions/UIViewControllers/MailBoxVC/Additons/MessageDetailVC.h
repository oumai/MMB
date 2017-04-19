//
//  MessageDetailVC.h
//  Mamabao
//
//  Created by Michael on 15/12/8.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailVC : UIViewController

@property (nonatomic, strong) NSString *backUserId;
@property (nonatomic, strong) NSString *discuss_id;
@property (nonatomic, strong) NSString *post_id;
@property (nonatomic, strong) NSString *backId;

@property (nonatomic, strong) NSString *backUserName;
@property (nonatomic, strong) NSString *backText;
@property (nonatomic, strong) NSString *backUserImg;


+ (void)pingLunTieZi;
@end
