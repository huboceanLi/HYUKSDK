//
//  HYUKInitTool.m
//  HYUKADSDK
//
//  Created by oceanMAC on 2023/5/19.
//

#import "HYUKInitTool.h"
#import "HYUKConfigManager.h"
//#import "HYUKLinkViewController.h"
#import <UMCommon/UMCommon.h>


@implementation HYUKInitTool

+ (void)initTool:(UIImage *)linkImage linkRect:(CGRect)rect window:(UIWindow *)window enter:(void (^)(BOOL pt))enter
{
    [[HYUKConfigManager shareInstance] getADData];
//
//
//    NSDictionary * infoDict = [[NSBundle mainBundle]infoDictionary];
//    [infoDict setValue:[HYUKConfigManager shareInstance].ADIDModel.GADApplicationIdentifier forKey:@"GADApplicationIdentifier"];

//    [UMConfigure initWithAppkey:[HYUKConfigManager shareInstance].ADIDModel.umAppkey channel:@"App Store"];

    [HYUKConfigManager shareInstance].linkImage = linkImage;
    [HYUKConfigManager shareInstance].linkRect = rect;
    
//    [NSThread sleepForTimeInterval:0.5];
//
//    HYUKLinkViewController *rootVC = [[HYUKLinkViewController alloc] init];//根控制器
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
//    window.rootViewController = nav;
//    window.backgroundColor = UIColor.whiteColor;
//    [window makeKeyAndVisible];
//    rootVC.successBlock = ^(BOOL rootVC) {
//        if (!rootVC) {
//            NSLog(@"进入主页");
//            enter(rootVC);
//        }
//    };

}

@end
