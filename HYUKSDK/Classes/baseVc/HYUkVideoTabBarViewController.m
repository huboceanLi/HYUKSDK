//
//  HYUkVideoTabBarViewController.m
//  HYVideoSDK_Example
//
//  Created by oceanMAC on 2023/3/31.
//  Copyright © 2023 admin@buzzmsg.com. All rights reserved.
//

#import "HYUkVideoTabBarViewController.h"
#import "HYUkHomeViewController.h"
#import "HYUkRankViewController.h"
#import "HYUkCenterViewController.h"
#import "HYUkHeader.h"
#import "UIImage+uk_bundleImage.h"


@interface HYUkVideoTabBarViewController ()

@end

@implementation HYUkVideoTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UITabBar appearance]setTintColor:[UIColor mainColor]];
    
    [[UITabBar appearance] setTranslucent:YES];
    
    HYUkHomeViewController *VC1 = [[HYUkHomeViewController alloc] init];
    [VC1.tabBarItem setImage:[[UIImage uk_bundleImage:@"uk_home_tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [VC1.tabBarItem setSelectedImage:[[UIImage uk_bundleImage:@"uk_home_selecttab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    VC1.tabBarItem.title = @"视频";

    HYUkRankViewController *VC2 = [[HYUkRankViewController alloc] init];
    [VC2.tabBarItem setImage:[[UIImage uk_bundleImage:@"uk_video_paihang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [VC2.tabBarItem setSelectedImage:[[UIImage uk_bundleImage:@"uk_video_selectpaihang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    VC2.tabBarItem.title = @"排行";
    
    HYUkCenterViewController *VC3 = [[HYUkCenterViewController alloc] init];
    [VC3.tabBarItem setImage:[[UIImage uk_bundleImage:@"uk_center_tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [VC3.tabBarItem setSelectedImage:[[UIImage uk_bundleImage:@"uk_center_selecttab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    VC3.tabBarItem.title = @"我的";

    
    self.viewControllers = @[VC1, VC2, VC3];
        
    if (@available(iOS 15.0, *)) {
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
    }
    [self setTabbarBackGround];
}

- (void)setTabbarBackGround{
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        appearance.backgroundImage = [self createImageWithColor:[UIColor clearColor]];
        appearance.shadowImage = [self createImageWithColor:[UIColor clearColor]];

        //下面这行代码最关键
        [appearance configureWithTransparentBackground];
        self.tabBar.standardAppearance = appearance;
    
    } else {
        [self.tabBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
        [self.tabBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    }
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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
