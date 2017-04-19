//
//  UIView+ASPhotoCategory.m
//  AngelSound
//
//  Created by Tear on 14-10-7.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import "UIView+ASPhotoCategory.h"

@implementation UIView (ASPhotoCategory)

- (void)showAnimation {
//    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
////    popAnimation.duration = 0.4;
//    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 100.0f, 0.0f)]
//                          ];
//    popAnimation.keyTimes = @[@0.1f, @0.5f];
//    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
//                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
//                                  ];
//    [self.layer addAnimation:popAnimation forKey:nil];
    self.frame = CGRectMake(0, kSCREEN_HEIGHT, self.frame.size.width
                            , self.frame.size.height);
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frame = CGRectMake(0, kSCREEN_HEIGHT-self.frame.size.height, self.frame.size.width
                                , self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

//隐藏action
-(void)hideAnimation{
//    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    hideAnimation.duration = 0.4;
//    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(1.1f, 1.1f, 1.0f)],
//                             [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(1.0f, 1.0f, 1.0f)],
//                             [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.00f, 0.00f, 0.00f)]];
//    hideAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f];
//    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
//                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
//                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [self removeFromSuperview];
//    [self.layer addAnimation:hideAnimation forKey:nil];
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frame = CGRectMake(0, kSCREEN_HEIGHT, self.frame.size.width
                                , self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}


@end
