//
//  ASChoicePhotoView.m
//  AngelSound
//
//  Created by jumper on 15/7/20.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASChoicePhotoView.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
/**布局框架**/
#import "Masonry.h"

/**动画扩展**/
#import "UIView+ASPhotoCategory.h"


@implementation ASChoicePhotoView
//初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.3;
        //添加移除手势
//        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAll)]];
//        
//        
        
        //init ImageArray
        self.imageArray = [[NSMutableArray alloc]init];
        
        self.isOK = NO;
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.photoView hideAnimation];
    [self removeFromSuperview];
}

/**
 *  移除手势
 */
-(void)removeAll{
    [self.photoView hideAnimation];
    [self removeFromSuperview];
}

/**
 *  添加
 *
 *  @param controller 父控制器
 *  @param count      照片个数
 */
-(void)addCon:(id)controller andView:(id)win andImageCount:(NSInteger)count{
    [self.imageArray removeAllObjects];
    
    self.photoView = [[ASPhotoView alloc]init];
    self.photoView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 120);
    [self.photoView.takePhotoButton addTarget:self action:@selector(takePhotos) forControlEvents:UIControlEventTouchUpInside];
    [self.photoView.albumButton addTarget:self action:@selector(takeAlbums) forControlEvents:UIControlEventTouchUpInside];
    [win addSubview:self.photoView];
    self.control = controller;
    self.imageCount = count;
    [self showChoice];
}

-(void)showChoice{
    [self.photoView showAnimation];
}

#pragma mark PhotoMethods
- (void)takePhotos {
     self.isOK = YES;
    UIImagePickerController *pPicker = [[UIImagePickerController alloc] init];
    pPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    pPicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    pPicker.delegate = self;
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    pPicker.mediaTypes = mediaTypes;
    [self.control presentViewController:pPicker animated:YES completion:nil];
    [self.photoView hideAnimation];
    [self removeFromSuperview];
}

- (void)takeAlbums {
     self.isOK = YES;
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] initWithStyle:UITableViewStyleGrouped];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.maximumNumberOfSelection = self.imageCount;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self.control presentViewController:navigationController animated:YES completion:NULL];
    [self.photoView hideAnimation];
    [self removeFromSuperview];
}
#pragma mark - PickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.isOK = NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker removeFromParentViewController];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageArray addObject:image];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate getImageArray:self.imageArray];
        });
    });
}

#pragma mark - QBImagePickerControllerDelegate
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    self.isOK = NO;
    for(int i = 0;i<assets.count;i++){
        ALAsset * asset = assets[i];
        ALAssetRepresentation* representation = [asset defaultRepresentation];
        UIImage* rti =  [UIImage imageWithCGImage:representation.fullScreenImage];
        [self.imageArray addObject:rti];
    }
    [self.delegate getImageArray:self.imageArray];
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    self.isOK = NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
