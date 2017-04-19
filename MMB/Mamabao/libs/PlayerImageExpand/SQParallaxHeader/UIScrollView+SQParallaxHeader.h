//
//  UIScrollView+SQParallaxHeader.h
//  QieyouMerchant
//
//  Created by 李赛强 on 14/12/25.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SQParallaxHeaderMode) {
    SQParallaxHeaderModeCenter = 0,
    SQParallaxHeaderModeFill,
    SQParallaxHeaderModeTop,
    SQParallaxHeaderModeTopFill,
};

typedef NS_ENUM(NSInteger, SQParallaxHeaderStickyViewPosition) {
    SQParallaxHeaderStickyViewPositionBottom = 0,
    SQParallaxHeaderStickyViewPositionTop,
};

typedef NS_ENUM(NSInteger, SQParallaxHeaderShadowBehaviour) {
    SQParallaxHeaderShadowBehaviourHidden = 0,
    SQParallaxHeaderShadowBehaviourAppearing,
    SQParallaxHeaderShadowBehaviourDisappearing,
    SQParallaxHeaderShadowBehaviourAlways,
} __deprecated;

@interface SQParallaxHeader : UIView
@property (nonatomic, assign, readonly) SQParallaxHeaderMode mode;

@property (nonatomic, assign, readwrite) SQParallaxHeaderStickyViewPosition stickyViewPosition;
@property (nonatomic, assign, readwrite) NSLayoutConstraint *stickyViewHeightConstraint;
@property (nonatomic, strong, readwrite) UIView *stickyView;

@property (nonatomic, assign, readonly, getter=isInsideTableView) BOOL insideTableView;
@property (nonatomic, assign, readonly) CGFloat progress;

@property (nonatomic, assign, readonly) SQParallaxHeaderShadowBehaviour shadowBehaviour __deprecated;

- (void)setStickyView:(UIView *)stickyView
           withHeight:(CGFloat)height;

@end

@interface UIScrollView (SQParallaxHeader)

@property (nonatomic, strong, readonly) SQParallaxHeader *parallaxHeader;

- (void)setParallaxHeaderView:(UIView *)view
                         mode:(SQParallaxHeaderMode)mode
                       height:(CGFloat)height;

- (void)setParallaxHeaderView:(UIView *)view
                         mode:(SQParallaxHeaderMode)mode
                       height:(CGFloat)height
              shadowBehaviour:(SQParallaxHeaderShadowBehaviour)shadowBehaviour __deprecated_msg("Use sticky view instead of shadow");

- (void)shouldPositionParallaxHeader;

@end
