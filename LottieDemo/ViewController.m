//
//  ViewController.m
//  LottieDemo
//
//  Created by le tong on 2019/12/17.
//  Copyright © 2019 le tong. All rights reserved.
//

#import "ViewController.h"
#import <Lottie/Lottie.h>

@interface ViewController ()

@property (nonatomic, strong) LOTAnimationView *animationView;
@property (nonatomic, strong) UIButton *pressButton;

@property (nonatomic, strong) LOTAnimationView *animationViewB;
@property (nonatomic, strong) UIButton *pressButtonB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.animationView];
    [self.view addSubview:self.animationViewB];
    [self.view addSubview:self.pressButton];
    [self.view addSubview:self.pressButtonB];
    // Do any additional setup after loading the view.
}

/*
 这么将动画分成两部分，通过点击来执行，当快速点击时会出现问题。美团的点击很顺滑. 使用stop
 */
- (void)pressButtonAction {
//    [self.animationView play];//播放动画

    NSLog(@"pressButtonAction isSelected");
    [self.animationViewB stop];
    if (self.animationView.animationProgress == 0 ) {
        [self.animationView playToProgress:0.5 withCompletion:^(BOOL animationFinished) {
            NSLog(@"pressButtonAction isSelected animation");

        }];
    }
}

- (void)pressButtonBAction {
    NSLog(@"pressButtonBAction");
    [self.animationView stop];//快速点击时候使用stop来停止动画，并且返回动画原点
    if (self.animationViewB.animationProgress == 0) {//当animationView没有开始的时候再开始动画
        [self.animationViewB playToProgress:0.5 withCompletion:^(BOOL animationFinished) {
            
        }];
    }
} 


#pragma mark ----lazy

- (LOTAnimationView *)animationView {
    if (!_animationView) {
        _animationView = [LOTAnimationView animationNamed:@"huiyuan"];
        _animationView.frame = CGRectMake(0, 200, 99, 86);
        _animationView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _animationView;
}
- (LOTAnimationView *)animationViewB {
    if (!_animationViewB) {
        _animationViewB = [LOTAnimationView animationNamed:@"dingdan"];
        _animationViewB.frame = CGRectMake(99*1, 200, 99, 86);
        _animationViewB.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _animationViewB;
}

- (UIButton *)pressButton {
    if (!_pressButton) {
        _pressButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 296, 99, 20)];
        [_pressButton setBackgroundColor:[UIColor yellowColor]];
        [_pressButton addTarget:self action:@selector(pressButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pressButton;
}
- (UIButton *)pressButtonB {
    if (!_pressButtonB) {
        _pressButtonB = [[UIButton alloc]initWithFrame:CGRectMake(99*1, 296, 99, 20)];
        [_pressButtonB setBackgroundColor:[UIColor orangeColor]];
        [_pressButtonB addTarget:self action:@selector(pressButtonBAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pressButtonB;
}


@end
