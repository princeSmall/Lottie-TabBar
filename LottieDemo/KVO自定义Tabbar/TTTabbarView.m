//
//  TTTabbarView.m
//  LottieDemo
//
//  Created by le tong on 2019/12/19.
//  Copyright © 2019 le tong. All rights reserved.
//

#import "TTTabbarView.h"
#import "TTItemButton.h"
#import <Lottie/Lottie.h>

@interface TTTabbarView()
@property (nonatomic, assign) NSInteger currentItem;

@end
@implementation TTTabbarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.currentItem = 1000;
    }
    return self;
}
- (void)itemButton:(NSInteger)itemNumber itemBlock:(nonnull itemButtonBlock)itemBlock{
    CGFloat itemW = [UIScreen mainScreen].bounds.size.width / itemNumber;
    CGFloat w = itemW / 2.0 - itemW / 2.0;
    NSArray *nameArray = @[@"huiyuan",@"fangzi",@"dingdan",@"wode"];
    for (int i = 0; i < itemNumber; i ++) {
        TTItemButton *item = [[TTItemButton alloc]initWithFrame:CGRectMake(w +itemW *i, 0, itemW, 66) ];
        item.tag = 100 + i;
        LOTAnimationView *LOTView = [LOTAnimationView animationNamed:nameArray[i]];
        LOTView.tag = item.tag + 100;
        LOTView.contentMode = UIViewContentModeScaleAspectFill;
        CGRect LOTViewFrame = item.frame;
        LOTViewFrame.origin.y = -16;
        [LOTView setFrame:LOTViewFrame];
        [self addSubview:LOTView];
        [item addTarget:self action:@selector(selectedButtonItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
    }
    [self setBeginAnimationLOTView];
    self.block = itemBlock;
}
- (void)setBeginAnimationLOTView{
    LOTAnimationView *LOTView = [self viewWithTag:200];
    if (LOTView.animationProgress == 0 ) {
        [LOTView playToProgress:0.5 withCompletion:^(BOOL animationFinished) {
            NSLog(@"pressButtonAction isSelected animation");
            
        }];
    }
}
- (void)selectedButtonItem:(UIButton *)sender{
    if (self.currentItem != sender.tag) {
        self.currentItem = sender.tag;
        LOTAnimationView *LOTView = [self viewWithTag:(sender.tag + 100)];
        for (LOTAnimationView *view in self.subviews) {
            if ([view isKindOfClass:[LOTAnimationView class]]) {
                [view stop];
            }
        }
        if (LOTView.animationProgress == 0 ) {
            [LOTView playToProgress:0.5 withCompletion:^(BOOL animationFinished) {
                NSLog(@"pressButtonAction isSelected animation");
                
            }];
        }
        self.block(sender.tag);
    }
}

@end
