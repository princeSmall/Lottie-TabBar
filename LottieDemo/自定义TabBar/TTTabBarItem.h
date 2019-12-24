//
//  LMTabBarItem.h
//  CustomTabBar
//
//  Created by le tong on 2019/12/18.
//  Copyright © 2019 le tong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LMTabBarItemDelegate;

@interface TTTabBarItem : UIView//继承自UIView

@property (nonatomic, strong) NSString *animationJsonName;

@property (nonatomic, weak) id <LMTabBarItemDelegate> delegate;

@end

@protocol LMTabBarItemDelegate <NSObject>

@optional

- (void)tabBarItem:(TTTabBarItem *)item didSelectIndex:(NSInteger)index;//代理处理点击事件

@end

NS_ASSUME_NONNULL_END
