//
//  JHShimmer.m
//  JHShimmer
//
//  Created by HaoCold on 2019/8/8.
//  Copyright © 2019 HaoCold. All rights reserved.
//

#import "JHShimmer.h"

@interface JHShimmer()
@property (nonatomic,  strong) UILabel *coverLabel;
@property (nonatomic,  strong) UIView *coverMaskView;

@property (nonatomic,  strong) NSTimer *timer;
@end

@implementation JHShimmer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _shimmerColor           = [UIColor whiteColor];
        _shimmerBackgroundColor = [UIColor blackColor];
        _shimmerWidth           = 30.0;
        _shimmerDuration        = 3.0;
        _shimmerInterval        = 1.0;
        
        [self addSubview:self.coverLabel];
        self.coverLabel.maskView = self.coverMaskView;
    }
    return self;
}

#pragma mark - override

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    CGRect bounds = self.coverMaskView.frame;
    bounds.size.height = frame.size.height;
    _coverMaskView.frame = bounds;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    _coverLabel.text = text;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _coverLabel.font = font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    _coverLabel.textAlignment = textAlignment;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    [super setLineBreakMode:lineBreakMode];
    _coverLabel.lineBreakMode = lineBreakMode;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    [super setNumberOfLines:numberOfLines];
    _coverLabel.numberOfLines = numberOfLines;
}

- (void)setAdjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth {
    [super setAdjustsFontSizeToFitWidth:adjustsFontSizeToFitWidth];
    _coverLabel.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
}

#pragma mark - private

- (void)setupForStyle
{
    if (_style == JHShimmerStyle_Normal) {
        _coverMaskView.backgroundColor = [UIColor greenColor];
    }else if (_style == JHShimmerStyle_Slanted) {
        CGSize size = _coverMaskView.bounds.size;
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [[UIColor whiteColor] set];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(size.width*0.5, 0)];
        [path addLineToPoint:CGPointMake(0, size.height)];
        [path addLineToPoint:CGPointMake(size.width*0.5, size.height)];
        [path addLineToPoint:CGPointMake(size.width, 0)];
        [path addLineToPoint:CGPointMake(size.width*0.5, 0)];
        
        CGContextAddPath(context, path.CGPath);
        CGContextDrawPath(context, kCGPathFill);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _coverMaskView.backgroundColor = [UIColor clearColor];
        _coverMaskView.layer.contents = (id)[image CGImage];
    }
}

- (void)animation
{
    __block CGRect frame = _coverMaskView.frame;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:_shimmerDuration delay:0.0 options:(UIViewAnimationOptions)_animationStyle animations:^{
        frame.origin.x = CGRectGetMaxX(weakSelf.coverLabel.frame);
        weakSelf.coverMaskView.frame = frame;
    } completion:^(BOOL finished) {
        if (weakSelf.shimmerOnce) {
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
        }else{
            frame.origin.x = -CGRectGetWidth(weakSelf.coverMaskView.frame);
            weakSelf.coverMaskView.frame = frame;
        }
    }];
}

#pragma mark - public

- (void)startShimmer
{
    if (!_timer) {
        self.timer.fireDate = [NSDate distantPast];
    }
}

- (void)stopShimmer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - lazy

- (void)setShimmerColor:(UIColor *)shimmerColor{
    _shimmerColor = shimmerColor;
    _coverLabel.textColor = shimmerColor;
}

- (void)setShimmerBackgroundColor:(UIColor *)shimmerBackgroundColor{
    _shimmerBackgroundColor = shimmerBackgroundColor;
    _coverLabel.backgroundColor = shimmerBackgroundColor;
}

- (void)setShimmerWidth:(CGFloat)shimmerWidth{
    _shimmerWidth = shimmerWidth;
    
    CGRect frame = self.coverMaskView.frame;
    frame.size.width = shimmerWidth;
    frame.origin.x = -shimmerWidth;
    _coverMaskView.frame = frame;
}

- (void)setStyle:(JHShimmerStyle)style{
    if (_style != style) {
        _style = style;
        [self setupForStyle];
    }
}

- (UILabel *)coverLabel{
    if (!_coverLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = self.bounds;
        label.textColor = _shimmerColor;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.backgroundColor = [UIColor blackColor];
        _coverLabel = label;
    }
    return _coverLabel;
}

- (UIView *)coverMaskView{
    if (!_coverMaskView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(-_shimmerWidth, 0, _shimmerWidth, CGRectGetHeight(self.bounds));
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        view.backgroundColor = _shimmerBackgroundColor;
        _coverMaskView = view;
    }
    return _coverMaskView;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_shimmerDuration+_shimmerInterval target:self selector:@selector(animation) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
