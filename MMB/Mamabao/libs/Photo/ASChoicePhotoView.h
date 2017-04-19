//
//  ASChoicePhotoView.h
//  AngelSound
//
//  Created by jumper on 15/7/20.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASChoicePhotoViewDelegate <NSObject>

-(void)getImageArray:(NSMutableArray *)array;

@end


/**图片选择器**/
#import "ASPhotoView.h"

/**第三方照片选择器**/
#import "QBImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ASChoicePhotoView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,QBImagePickerControllerDelegate>

@property  (strong , nonatomic)ASPhotoView *photoView;

/**代理方法**/
@property (nonatomic, retain) id <ASChoicePhotoViewDelegate> delegate;

/**图片数组**/
@property (strong , nonatomic)NSMutableArray *imageArray;

/**父视图控制器**/
@property (strong , nonatomic)id control;

/**照片个数**/
@property (assign , nonatomic)NSInteger imageCount;

/**用于判断是否去掉隐藏nav,视情况而定**/
@property (assign)BOOL isOK;

/**
 *  添加VIew
 *
 *  @param controller
 */
-(void)addCon:(id)controller andView:(id)win andImageCount:(NSInteger)count;

@end
