//
//  UIImage+Image.m
//  
//
//  Created by yz on 15/7/6.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f,kSCREEN_WIDTH, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage*)scaledToSize:(UIImage *)myImage
{
    UIImage *tranImage = nil;
    
    if (myImage.size.width>640||myImage.size.height>1136)
    {
        float scaleMM = 1.0f;
        CGFloat width = 640.0f;
        CGFloat height = 1136.0f;
        CGSize sizeMM = CGSizeMake(width, height);
        if (myImage.size.width>640&&myImage.size.height<=1136)
        {
            scaleMM = myImage.size.width/640;
            height = myImage.size.height/scaleMM;
            sizeMM = CGSizeMake(width,height);
        }
        else if(myImage.size.width<=640&&myImage.size.height>1136)
        {
            scaleMM = myImage.size.height/1136;
            width = myImage.size.width/scaleMM;
            sizeMM = CGSizeMake(width,height);
        }
        else
        {
            scaleMM = (myImage.size.height/1136)>=(myImage.size.width/640)?(myImage.size.height/1136):(myImage.size.width/640);
            width = myImage.size.width/scaleMM;
            height = myImage.size.height/scaleMM;
            sizeMM = CGSizeMake(width, height);
        }
        
        tranImage = [self imageWithImageSimple:myImage scaledToSize:sizeMM];
    }
    else
    {
        tranImage = myImage;
    }
    NSLog(@"_________myImage.size:%@",NSStringFromCGSize(tranImage.size));
    return tranImage;
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}


@end
