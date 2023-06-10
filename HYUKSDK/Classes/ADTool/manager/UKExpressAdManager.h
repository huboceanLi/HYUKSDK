//
//  UKExpressAdManager.h
//  HYUKADSDK
//
//  Created by Ocean 李 on 2023/6/4.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>
#import <BUAdSDK/BUNativeExpressAdManager.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UKExpressAdStatus) {
    expressAd_start,
    expressAd_loading,
    expressAd_end,
    expressAd_error
};

@interface UKExpressAdManager : NSObject

+(UKExpressAdManager *)shared;

//- (void)loadExpressAdWithVC:(UIViewController *)vc rect:(CGRect)rect show:(void (^)(void))show;

- (void)loadExpressAdWithVC1:(UIViewController *)vc rect:(CGRect)rect show:(void (^)(UKExpressAdStatus status))show;

@end

NS_ASSUME_NONNULL_END
