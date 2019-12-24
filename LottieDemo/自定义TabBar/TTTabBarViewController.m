//
//  BaseTabBarViewController.m
//  CustomTabBar
//
//  Created by le tong on 2019/12/17.
//  Copyright © 2019 le tong. All rights reserved.
//

#import "TTTabBarViewController.h"
#import "TTTabBar.h"
#import "TTTabBarItem.h"
#import <Lottie/Lottie.h>

static CGFloat LMTabBarHeight = 48.0;

@interface TTTabBarViewController ()<LMTabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) TTTabBar *customTabBar;

@property (nonatomic, copy) NSArray *lmViewControllers;

@property (nonatomic, assign) NSInteger currentItem;
@end

@implementation TTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedIndex = 0;
    [self setupChildVC];
    self.delegate = self;
    // Do any additional setup after loading the view.
}
 

#pragma mark ----setupChildVC

- (void)setupChildVC {

    UIViewController *avc = [[UIViewController alloc]init];
    UIViewController *bvc = [[UIViewController alloc]init];
    UIViewController *cvc = [[UIViewController alloc]init];
    UIViewController *dvc = [[UIViewController alloc]init];
    
    self.lmViewControllers = @[avc,bvc,cvc,dvc];
    [self setupCustomTabBarItems];
}

/// 设置自定义的tabBar
- (void)setupCustomTabBarItems {
    self.tabBar.hidden = YES;
    
    //创建items数组
    NSArray *animationJsonNameArray = @[@"fangzi",@"huiyuan",@"dingdan",@"wode"];
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < self.lmViewControllers.count; i++) {
        TTTabBarItem *item = [[TTTabBarItem alloc]init];
        item.animationJsonName = animationJsonNameArray[i];
        [items addObject:item];
        item.tag = i;
    }
    [self setBeginItemAnimation:items[0] item:0];
    self.customTabBar.LMItems = [items copy];
    
    [self.view addSubview:self.customTabBar];
    self.customTabBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - LMTabBarHeight, CGRectGetWidth(self.view.frame), LMTabBarHeight);
}


#pragma mark ----UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}


#pragma mark - LMTabBarDelegate

- (void)tabBar:(TTTabBar *)tab didSelectItem:(TTTabBarItem *)item atIndex:(NSInteger)index {
    
    if (self.currentItem != index) {
        TTTabBarItem *tabBarItem = tab.LMItems[self.currentItem];
        [self setStopItemAnimationWithItem:tabBarItem];
        [self setBeginItemAnimation:item item:index];
    }
    self.selectedIndex = index;
}
// 1. 设置首次动画
// 2. 保存上次动画的item
- (void)setBeginItemAnimation:(TTTabBarItem *)itemView item:(NSInteger)item{
    for (LOTAnimationView *view in itemView.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"LOTAnimationView")]) {
            if (view.animationProgress == 0 ){
                _currentItem = item;
                [view  playToProgress:0.5f withCompletion:^(BOOL animationFinished) {
                }];
            }
            break;
        }
    }
}
// 根据上次动画的item关闭上次动画
- (void)setStopItemAnimationWithItem:(TTTabBarItem *)item {
    for (UIView *view in item.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"LOTAnimationView")]) {
           LOTAnimationView *animationView = (LOTAnimationView *)view;
           [animationView stop];
            break;
        }
    }
    
}


#pragma mark ----lazy
- (TTTabBar *)customTabBar {
    if (!_customTabBar) {
        _customTabBar = [[TTTabBar alloc]init];
        _customTabBar.backgroundColor = [UIColor whiteColor];
        _customTabBar.lmDelegate = self;
    }
    return _customTabBar;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
