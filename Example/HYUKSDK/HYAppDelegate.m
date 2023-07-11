//
//  HYAppDelegate.m
//  HYUKSDK
//
//  Created by li437277219@gmail.com on 04/27/2023.
//  Copyright (c) 2023 li437277219@gmail.com. All rights reserved.
//

#import "HYAppDelegate.h"
#import <HYUKSDK/HYUkHeader.h>
#import "HYViewController.h"

@interface HYAppDelegate()
<HYUkVideoInitDelegate>

@end
@implementation HYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    
    __weak typeof(self) weakSelf = self;
        
    [HYUKInitTool initTool:[UIImage imageNamed:@"引导页"] icon:[UIImage imageNamed:@"引导页"] linkRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) window:self.window enter:^(BOOL pt) {
        if (!pt) {
            HYUkVideoTabBarViewController *tabBar = [HYUkVideoTabBarViewController new];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBar];
            weakSelf.window.rootViewController = nav;
            [weakSelf.window makeKeyAndVisible];
        }else {
            HYViewController *tabBar = [HYViewController new];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBar];
            weakSelf.window.rootViewController = nav;
            [weakSelf.window makeKeyAndVisible];
        }
    }];
    
    // Override point for customization after application launch.

//    HYUkLinkViewController * loginVC = [[HYUkLinkViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    self.window.rootViewController = nav;
//    HYUkVideoTabBarViewController *tabBar = [HYUkVideoTabBarViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBar];
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];

    [HYUkVideoConfigManager sharedInstance].delegate = self;

    return YES;
}

- (void)changeOrientation:(BOOL)isOrientation
{
    if (isOrientation) {
        self.allowRotate = 1;
    }else {
        self.allowRotate = 0;
    }
}

//此方法会在设备横竖屏变化的时候调用
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
     if (self.allowRotate == 1) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}
// 返回是否支持设备自动旋转
- (BOOL)shouldAutorotate
{
    if (self.allowRotate == 1) {
        return YES;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
