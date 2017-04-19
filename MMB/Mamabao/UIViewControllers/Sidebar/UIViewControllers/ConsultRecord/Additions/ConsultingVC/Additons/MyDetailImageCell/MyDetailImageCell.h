//
//  MyDetailImageCell.h
//  Mamabao
//
//  Created by Michael on 16/1/8.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDetailModel.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface MyDetailImageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconRightImage;
@property (nonatomic, strong) MyDetailModel *myDetailImageModel;

@end
