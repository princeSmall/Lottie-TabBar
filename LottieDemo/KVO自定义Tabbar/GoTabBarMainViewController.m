//
//  GoTabBarMainViewController.m
//  Objective-c-Go
//
//  Created by le tong on 2019/3/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "GoTabBarMainViewController.h"
#import "GoTabbarChildSetViewController.h"
#import "GoTabbarChildMessageViewController.h"
#import "TTCustomTabbar.h"

@interface GoTabBarMainViewController ()<CustomTabBarDelegate>
@property (nonatomic, strong) NSArray *itemArr;

@end

@implementation GoTabBarMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TTCustomTabbar *customBar = [[TTCustomTabbar alloc]init];
    customBar.barDelegate = self;
    [self setValue:customBar forKey:@"tabBar"];
    [self addAllChildViewController];
    // Do any additional setup after loading the view.
}

- (void)selectedItemButton:(NSInteger)item{
    self.selectedIndex = item - 100;
}
- (void)addAllChildViewController {
    GoTabbarChildMessageViewController *homeVC = [[GoTabbarChildMessageViewController alloc] init];
    homeVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:homeVC title:@"首页" imageNamed:@"tabBar_home"];
    
    GoTabbarChildSetViewController *activityVC = [[GoTabbarChildSetViewController alloc] init];
    activityVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:activityVC title:@"活动" imageNamed:@"tabBar_activity"];
    
    UIViewController *findVC = [[UIViewController alloc] init];
    findVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:findVC title:@"发现" imageNamed:@"tabBar_find"];
    
    UIViewController *mineVC = [[UIViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:mineVC title:@"我的" imageNamed:@"tabBar_mine"];
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


/**
 修改tabbar的高度
 */
- (void)viewWillLayoutSubviews {
    
//        CGRect tabFrame = self.tabBar.frame;
//        tabFrame.size.height = 59;
//        tabFrame.origin.y = self.view.bounds.size.height - 59;
//        self.tabBar.frame = tabFrame;
}


@end
