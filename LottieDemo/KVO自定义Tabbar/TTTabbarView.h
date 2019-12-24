//
//  TTTabbarView.h
//  LottieDemo
//
//  Created by le tong on 2019/12/19.
//  Copyright © 2019 le tong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^itemButtonBlock)(NSInteger item);

@interface TTTabbarView : UIView
@property (nonatomic, copy)itemButtonBlock block;
- (void)itemButton:(NSInteger)itemNumber itemBlock:(itemButtonBlock)itemBlock;
@end

NS_ASSUME_NONNULL_END
