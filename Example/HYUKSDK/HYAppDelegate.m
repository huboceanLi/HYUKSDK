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
#import <SJRotationManager.h>
#import <HYUKSDK/HYUkHeader.h>


@interface HYAppDelegate()<YXTypeManagerDelegate>


@end
@implementation HYAppDelegate

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    UIInterfaceOrientationMask mask = [SJRotationManager supportedInterfaceOrientationsForWindow:window];
    NSLog(@"orientations: %ld, %@", mask, NSStringFromClass(window.class));
    return mask;
}

- (BOOL)shouldAutorotate {
    return NO;
}
//
/////
///// 控制器旋转支持的方向
/////
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [YXTypeManager shareInstance].delegate = self;

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    
        
    HYUkHomeViewController *tabBar = [HYUkHomeViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBar];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.

//    HYUkLinkViewController * loginVC = [[HYUkLinkViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    self.window.rootViewController = nav;
//    HYUkVideoTabBarViewController *tabBar = [HYUkVideoTabBarViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBar];
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];


    return YES;
}

- (void)showAdWithType:(FromWayType)type
{
    if (type == FromWayType_detail_banner) {

        UIView *v = [UIView new];
        [[YXTypeManager shareInstance] showBannerAdWithResult:YES adView:v];
    }else {
        [[YXTypeManager shareInstance] showAdWithResult:YES];
    }
    
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
