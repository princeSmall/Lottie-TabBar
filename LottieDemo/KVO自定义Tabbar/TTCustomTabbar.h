//
//  TTCustomTabbar.h
//  LottieDemo
//
//  Created by le tong on 2019/12/19.
//  Copyright © 2019 le tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTabbarView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CustomTabBarDelegate <NSObject>

- (void)selectedItemButton:(NSInteger)item;

@end

@interface TTCustomTabbar : UITabBar

@property (nonatomic, weak) id <CustomTabBarDelegate> barDelegate;
@property (nonatomic, strong) TTTabbarView *tttabbarView;

@end

NS_ASSUME_NONNULL_END
