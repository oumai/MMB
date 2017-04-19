//
//  ASPhotoView.h
//  AngelSound
//
//  Created by Tear on 14-10-6.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASPhotoView : UIView <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)UIButton *takePhotoButton;

@property (nonatomic, strong)UIButton *albumButton;



@end
