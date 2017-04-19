//
//  ASConsultDoctorMp3TableViewCell.m
//  AngelSound
//
//  Created by jumper on 15/9/17.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASConsultDoctorMp3TableViewCell.h"

@implementation ASConsultDoctorMp3TableViewCell

- (void)awakeFromNib {
    self.doctorImageView.layer.masksToBounds = YES;
    self.doctorImageView.layer.cornerRadius = self.doctorImageView.frame.size.width/2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"doctormp3Cell";
    ASConsultDoctorMp3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ASConsultDoctorMp3TableViewCell class]) owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setContentModel:(MyDetailModel *)contentModel{
    
    _contentModel = contentModel;
    
    self.timeLable.text = contentModel.created_time;
    
    self.lenthLable.text = [NSString stringWithFormat:@"%ld\"",(long)contentModel.length];
    
    self.backGroundImageView.image = [[UIImage imageNamed:@"doctor"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 40, 20, 20) resizingMode:UIImageResizingModeStretch ];

    contentModel.cellHeight = 85;
}

@end
