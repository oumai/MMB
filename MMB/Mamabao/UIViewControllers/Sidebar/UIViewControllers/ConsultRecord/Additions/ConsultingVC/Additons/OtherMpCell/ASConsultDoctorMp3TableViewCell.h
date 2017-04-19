//
//  ASConsultDoctorMp3TableViewCell.h
//  AngelSound
//
//  Created by jumper on 15/9/17.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyDetailModel.h"

#import "UIImageView+WebCache.h"

@interface ASConsultDoctorMp3TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *doctorImageView;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;

@property (weak, nonatomic) IBOutlet UILabel *lenthLable;

@property (weak, nonatomic) IBOutlet UIImageView *mp3ImageView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (strong , nonatomic)MyDetailModel *contentModel;

@end
