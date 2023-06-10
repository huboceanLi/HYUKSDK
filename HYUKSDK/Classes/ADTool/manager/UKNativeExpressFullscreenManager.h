//
//  UKNativeExpressFullscreenManager.h
//  HYUKADSDK
//
//  Created by Ocean 李 on 2023/6/4.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>
#import <BUAdSDK/BUNativeExpressRewardedVideoAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface UKNativeExpressFullscreenManager : NSObject

+(UKNativeExpressFullscreenManager *)shared;

- (void)loadExpressAdWithVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
