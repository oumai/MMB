//
//  SQImagePlayerView.h
//  SQImagePlayerView
//
//  Created by 李赛强 on 15/7/27.
//  Copyright (c) 2015年 李赛强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SQPageControlPosition) {
    SQPageControlPosition_TopLeft,
    SQPageControlPosition_TopCenter,
    SQPageControlPosition_TopRight,
    SQPageControlPosition_BottomLeft,
    SQPageControlPosition_BottomCenter,
    SQPageControlPosition_BottomRight
};

@protocol SQImagePlayerViewDelegate;

@interface SQImagePlayerView : UIView
@property (nonatomic, assign) id<SQImagePlayerViewDelegate> imagePlayerViewDelegate;
@property (nonatomic, assign) BOOL autoScroll;
@property (nonatomic, assign) NSUInteger scrollInterval;
@property (nonatomic, assign) SQPageControlPosition pageControlPosition;
@property (nonatomic, assign) BOOL hidePageControl;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

- (void)reloadData;
- (void)stopTimer;

#pragma mark - deprecated methods

- (void)initWithImageURLs:(NSArray *)imageURLs
              placeholder:(UIImage *)placeholder
                 delegate:(id<SQImagePlayerViewDelegate>)delegate ;

- (void)initWithImageURLs:(NSArray *)imageURLs
              placeholder:(UIImage *)placeholder
                 delegate:(id<SQImagePlayerViewDelegate>)delegate
               edgeInsets:(UIEdgeInsets)edgeInsets;

- (void)initWithCount:(NSInteger)count
             delegate:(id<SQImagePlayerViewDelegate>)delegate ;

- (void)initWithCount:(NSInteger)count
             delegate:(id<SQImagePlayerViewDelegate>)delegate
           edgeInsets:(UIEdgeInsets)edgeInsets ;
@end


#pragma mark - SQImagePlayerViewDelegate
@protocol SQImagePlayerViewDelegate <NSObject>
@required
- (NSInteger)numberOfItems;
- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index;

@optional
- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index;
- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index imageURL:(NSURL *)imageURL;

@end