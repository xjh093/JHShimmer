//
//  ViewController.m
//  JHShimmer
//
//  Created by HaoCold on 2019/8/8.
//  Copyright © 2019 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "JHShimmer.h"

@interface ViewController ()
@property (nonatomic,  strong) JHShimmer *shimmer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    JHShimmer *shimmer = [[JHShimmer alloc] init];
    shimmer.frame = CGRectMake(0, 0, 200, 50);
    shimmer.text = @"A shimer Label.";
    shimmer.textAlignment = 1;
    shimmer.numberOfLines = 0;
    shimmer.font = [UIFont systemFontOfSize:30];
    shimmer.center = self.view.center;
    shimmer.backgroundColor = [UIColor grayColor];
    [self.view addSubview:shimmer];
    
    shimmer.shimmerWidth = 50;
    shimmer.shimmerColor = [UIColor whiteColor]; // Default
    shimmer.shimmerBackgroundColor = [UIColor blackColor]; // Default
    shimmer.style = JHShimmerStyle_Slanted;
    shimmer.animationStyle = JHShimmerAnimationStyle_EaseInOut;
    shimmer.shimmerDuration = 1.5;
    [shimmer startShimmer];
    
    _shimmer = shimmer;
    
    {
    JHShimmer *shimmer = [[JHShimmer alloc] init];
    shimmer.frame = CGRectMake(CGRectGetMinX(_shimmer.frame), CGRectGetMaxY(_shimmer.frame)  + 10, 200, 50);
    shimmer.text = @"A shimer Label.";
    shimmer.textAlignment = 1;
    shimmer.numberOfLines = 0;
    shimmer.font = [UIFont systemFontOfSize:30];
    shimmer.backgroundColor = [UIColor grayColor];
    [self.view addSubview:shimmer];
    
    shimmer.shimmerWidth = 50;
    shimmer.shimmerColor = [UIColor yellowColor];
    shimmer.shimmerBackgroundColor = [UIColor clearColor];
    shimmer.style = JHShimmerStyle_Slanted;
    shimmer.animationStyle = JHShimmerAnimationStyle_EaseIn;
    shimmer.shimmerDuration = 2;
    [shimmer startShimmer];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_shimmer.style == JHShimmerStyle_Normal) {
        _shimmer.style = JHShimmerStyle_Slanted;
    }else if (_shimmer.style == JHShimmerStyle_Slanted) {
        _shimmer.style = JHShimmerStyle_Normal;
    }
}

@end
