//
//  LMTabBar.m
//  CustomTabBar
//
//  Created by le tong on 2019/12/18.
//  Copyright © 2019 le tong. All rights reserved.
//

#import "TTTabBar.h"
#import "TTTabBarItem.h"

//主要是将系统的item移除掉, 然后添加上自定义的item:
@interface TTTabBar ()<LMTabBarItemDelegate>

@end

@implementation TTTabBar

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 移除系统的tabBarItem
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *item in self.subviews) {
        if ([item isKindOfClass:class]) {
            [item removeFromSuperview];
        }
    }
    // 设置自定义的tabBarItem
    [self setupItems];
}


/// 设置自定义的tabbarItem
- (void)setupItems {
    CGFloat width = self.frame.size.width/self.LMItems.count;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < self.LMItems.count; i++) {
        TTTabBarItem *item = [self.LMItems objectAtIndex:i];
        item.frame = CGRectMake(i*width, 0, width, height);
        [self addSubview:item];
        item.delegate = self;
    }
}


#pragma mark ----LMTabBarItemDelegate

- (void)tabBarItem:(TTTabBarItem *)item didSelectIndex:(NSInteger)index {
    if (self.lmDelegate && [self.lmDelegate respondsToSelector:@selector(tabBar:didSelectItem:atIndex:)]) {
        [self.lmDelegate tabBar:self didSelectItem:item atIndex:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
