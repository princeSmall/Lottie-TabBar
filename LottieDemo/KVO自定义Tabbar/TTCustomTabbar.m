//
//  TTCustomTabbar.m
//  LottieDemo
//
//  Created by le tong on 2019/12/19.
//  Copyright © 2019 le tong. All rights reserved.
//

#import "TTCustomTabbar.h"

@implementation TTCustomTabbar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tttabbarView];
    }
    return self;
}
- (TTTabbarView *)tttabbarView{
    if (!_tttabbarView) {
        _tttabbarView = [[TTTabbarView alloc]initWithFrame:self.bounds];
        [_tttabbarView itemButton:4 itemBlock:^(NSInteger item) {
            if (self->_barDelegate && [self->_barDelegate respondsToSelector:@selector(selectedItemButton:)]) {
                [self->_barDelegate selectedItemButton:item];
            }
        }];
    }
    return _tttabbarView;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置tabBarView的frame
    self.tttabbarView.frame = self.bounds;
    // 把tabBarView带到最前面，覆盖tabBar的内容
    [self bringSubviewToFront:self.tttabbarView];
}




@end
