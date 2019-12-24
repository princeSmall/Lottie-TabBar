//
//  AppDelegate.m
//  LottieDemo
//
//  Created by le tong on 2019/12/17.
//  Copyright © 2019 le tong. All rights reserved.
//

#import "AppDelegate.h"
#import "GoTabBarMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    GoTabBarMainViewController *vc = [[GoTabBarMainViewController alloc]init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}





@end
