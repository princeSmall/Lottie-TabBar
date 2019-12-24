//
//  LMTabBarItem.m
//  CustomTabBar
//
//  Created by le tong on 2019/12/18.
//  Copyright © 2019 le tong. All rights reserved.
//

#import "TTTabBarItem.h"
#import <Lottie/Lottie.h>

static NSInteger defaultTag = 100000;

@interface TTTabBarItem ()

@property (nonatomic, strong) LOTAnimationView *animationView;//动画view

@end

@implementation TTTabBarItem

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.animationView];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItem:)];
        [self.animationView addGestureRecognizer:gesture];
    }
    return self;
}

// 重写setTag方法 TODO 这个用法第一次
- (void)setTag:(NSInteger)tag {
    [super setTag:tag + defaultTag];
}

/// item点击手势，响应点击事件
- (void)tapItem:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarItem:didSelectIndex:)]) {
        [self.delegate tabBarItem:self didSelectIndex:self.tag - defaultTag];
    }
}

- (void)setAnimationJsonName:(NSString *)animationJsonName {//set方法设置动画view的数据
    _animationJsonName = animationJsonName;
    [self.animationView setAnimationNamed:animationJsonName];
}

/// 为什么在这个方法里面写布局
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.frame;
    rect.origin.x = 0;
    rect.origin.y = -35;
    rect.size.height += 20;
    self.animationView.frame = rect;
}


#pragma mark ----lazy

- (LOTAnimationView *)animationView {
    if (!_animationView) {
        _animationView = [[LOTAnimationView alloc]init];
        _animationView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _animationView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
