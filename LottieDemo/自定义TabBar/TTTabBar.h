//
//  LMTabBar.h
//  CustomTabBar
//
//  Created by le tong on 2019/12/18.
//  Copyright © 2019 le tong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TTTabBarItem;
@protocol LMTabBarDelegate;

@interface TTTabBar : UITabBar//继承自UITabBar

@property (nonatomic, copy) NSArray<TTTabBarItem *> *LMItems;//item数组
@property (nonatomic, weak) id <LMTabBarDelegate> lmDelegate;

@end

@protocol LMTabBarDelegate <NSObject>

- (void)tabBar:(TTTabBar *)tab didSelectItem:(TTTabBarItem *)item atIndex:(NSInteger)index ;

@end
NS_ASSUME_NONNULL_END
