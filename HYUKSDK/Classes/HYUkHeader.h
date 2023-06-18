//
//  HYUkHeader.h
//  Pods
//
//  Created by oceanMAC on 2023/4/27.
//

#ifndef HYUkHeader_h
#define HYUkHeader_h

#import <QMUIKit/QMUIKit.h>
//#import <YYKit/YYKit.h>
#import <YYText/YYText.h>
#import <YYModel/YYModel.h>
#import <YYWebImage/YYWebImage.h>
#import <YYCategories/YYCategories.h>

#import "MBProgressHUD+JDragon.h"
#import <JXCategoryView/JXCategoryView.h>
#import <HYUKSDK/HYUkHeader.h>
#import <CTNetworking/CTNetworking.h>
#import <HYBaseTool/HYBaseTool.h>

#import "UIColor+UkPublicUse.h"
#import "HYUkVideoTabBarViewController.h"
#import "UIImage+uk_bundleImage.h"
#import "BadgeButton.h"
#import "UICollectionView+EmptyView.h"
#import "UITableView+EmptyView.h"
#import "HYUkShowLoadingManager.h"
#import "HYVideoSingle.h"
#import "BaseModel.h"
#import "HYUkVideoConfigManager.h"
#import "HYUkVideoDetailModel.h"
#import "HYResponseCategeryModel.h"
#import "HYResponseVideoListModel.h"
#import "HYResponseSearchModel.h"
#import "HYUkTextTempModel.h"
#import "HYUkTempCategaryModel.h"
#import "MYToast.h"
#import "APIString.h"
#import "MYDialogViewController.h"
#import "HYUkDownManager.h"
#import "HYUKADHeader.h"
#import "AdaptScreen.h"

#define IS_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define SDKVersion @"1.0.0"

#endif /* HYUkHeader_h */
