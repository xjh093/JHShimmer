//
//  JHShimmer.h
//  JHShimmer
//
//  Created by HaoCold on 2019/8/8.
//  Copyright © 2019 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JHShimmerStyle) {
    JHShimmerStyle_Normal,
    JHShimmerStyle_Slanted,
};

typedef NS_ENUM(NSUInteger, JHShimmerAnimationStyle) {
    JHShimmerAnimationStyle_EaseInOut = UIViewAnimationOptionCurveEaseInOut,
    JHShimmerAnimationStyle_EaseIn    = UIViewAnimationOptionCurveEaseIn,
    JHShimmerAnimationStyle_EaseOut   = UIViewAnimationOptionCurveEaseOut,
    JHShimmerAnimationStyle_Linear    = UIViewAnimationOptionCurveLinear,
};

@interface JHShimmer : UILabel
/// Default is white.
@property (nonatomic,  strong) UIColor                  *shimmerColor;
/// Default is black.
@property (nonatomic,  strong) UIColor                  *shimmerBackgroundColor;
/// Default is 30.
@property (nonatomic,  assign) CGFloat                  shimmerWidth;
/// Default is 3.
@property (nonatomic,  assign) CGFloat                  shimmerDuration;
/// Default is 1.
@property (nonatomic,  assign) CGFloat                  shimmerInterval;
/// Default is NO.
@property (nonatomic,  assign) BOOL                     shimmerOnce;
/// JHShimmerStyle_Normal
@property (nonatomic,  assign) JHShimmerStyle           style;
/// JHShimmerAnimationStyle_EaseInOut
@property (nonatomic,  assign) JHShimmerAnimationStyle  animationStyle;

- (void)startShimmer;
- (void)stopShimmer;

@end

NS_ASSUME_NONNULL_END

