//
//  YueZiCenterDetailVC.h
//  Mamabao
//
//  Created by Michael on 15/11/27.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YueZiCenterDetailVC : UIViewController

@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, strong) NSString *entity_id;
@property (nonatomic, strong) NSString *isNanny;

+(CGFloat)heightFotIntroduce:(NSString *)string;
@end
