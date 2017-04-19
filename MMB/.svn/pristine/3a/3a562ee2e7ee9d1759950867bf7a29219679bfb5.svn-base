//
//  ASPhotoView.m
//  AngelSound
//
//  Created by Tear on 14-10-6.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import "ASPhotoView.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
/**布局框架**/
#import "Masonry.h"

@implementation ASPhotoView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        UIView *takeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH/2, self.frame.size.height)];
        takeView.backgroundColor = [UIColor clearColor];
        
        UILabel *lable = [[UILabel alloc]init];
        lable.text = @"选取图片";
        lable.textColor = [UIColor whiteColor];
        lable.font = [UIFont fontWithName:nil size:16.0];
        lable.backgroundColor = BaseColor;
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
    
        self.takePhotoButton = [[UIButton alloc]init];
        [self.takePhotoButton setBackgroundImage:[UIImage imageNamed:@"head_revision_camera"] forState:UIControlStateNormal];
        [self.takePhotoButton setBackgroundImage:[UIImage imageNamed:@"head_revision_camera"] forState:UIControlStateHighlighted];
        [self addSubview:self.takePhotoButton];
        

        UILabel *photoLable = [[UILabel alloc]init];
        photoLable.text = @"拍 照";
        photoLable.textColor = K_CustomColor(125, 122, 123);
        photoLable.textAlignment = 1;
        photoLable.font = [UIFont fontWithName:nil size:15.0];
        [self addSubview:photoLable];
        
        self.albumButton = [[UIButton alloc]init];
        [self.albumButton setBackgroundImage:[UIImage imageNamed:@"head_revision_picture"] forState:UIControlStateNormal];
        [self.albumButton setBackgroundImage:[UIImage imageNamed:@"head_revision_picture"] forState:UIControlStateHighlighted];
        [self addSubview:self.albumButton];
        UILabel *albumButton = [[UILabel alloc]init];
        albumButton.text = @"从相册中获取";
        albumButton.textColor = K_CustomColor(125, 122, 123);
        albumButton.textAlignment = 1;
        albumButton.font = [UIFont fontWithName:nil size:15.0];
        [self addSubview:albumButton];

        //添加约束
        [lable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(0);
            make.right.equalTo(self.right).offset(0);
            make.top.equalTo(self.top).offset(0);
            make.height.equalTo(30);
        }];
        
        [self.takePhotoButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lable.bottom).offset(10);
            make.width.equalTo(50);
            make.height.equalTo(40);
            make.centerX.equalTo(self.centerX).offset(-kSCREEN_WIDTH/4);
        }];
        
        [photoLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(80);
            make.centerX.equalTo(self.centerX).offset(-kSCREEN_WIDTH/4);
            make.height.equalTo(30);
            make.width.equalTo(100);
        }];
        
        
        [self.albumButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX).offset(kSCREEN_WIDTH/4);
            make.top.equalTo(lable.bottom).offset(10);
            make.width.equalTo(40);
            make.height.equalTo(40);
        }];

        [albumButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(80);
            make.centerX.equalTo(self.centerX).offset(kSCREEN_WIDTH/4);
            make.height.equalTo(30);
            make.width.equalTo(100);
        }];
    }
    return self;
}


@end
