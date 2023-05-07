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
#import <JXCategoryView/JXCategoryView.h>
#import <HYUKSDK/HYUkHeader.h>
#import <CTNetworking/CTNetworking.h>

#import "UIColor+UkPublicUse.h"
#import "HYUkVideoTabBarViewController.h"
#import "UIImage+uk_bundleImage.h"
#import "BadgeButton.h"
#import "UICollectionView+UKEmptyView.h"
#import "UITableView+UKEmptyView.h"
#import "HYUkShowLoadingManager.h"
#import "HYVideoSingle.h"
#import "BaseModel.h"
#import "HYUkConfigManager.h"
#import "HYUkVideoDetailModel.h"
#import "HYResponseCategeryModel.h"
#import "HYResponseVideoListModel.h"
#import "HYResponseSearchModel.h"
#import "HYUkTextTempModel.h"

#define IS_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#endif /* HYUkHeader_h */
