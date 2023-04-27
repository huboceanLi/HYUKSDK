//
//  HYUkHeader.h
//  Pods
//
//  Created by oceanMAC on 2023/4/27.
//

#ifndef HYUkHeader_h
#define HYUkHeader_h

#import <QMUIKit/QMUIKit.h>
#import <YYKit/YYKit.h>
//#import "MBProgressHUD+JDragon.h"
#import <HYBaseTool/HYBaseTool.h>

#import "UIColor+PublicUse.h"
#import "HYUkVideoTabBarViewController.h"
#import "UIImage+sdk_bundleImage.h"

#define IS_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#endif /* HYUkHeader_h */
