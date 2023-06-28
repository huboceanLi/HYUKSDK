//
//  UKNativeExpressFullscreenManager.m
//  HYUKADSDK
//
//  Created by Ocean 李 on 2023/6/4.
//

#import "UKNativeExpressFullscreenManager.h"
#import "HYUKConfigManager.h"
#import <HYBaseTool/HYBaseTool.h>
#import "APIString.h"

static UKNativeExpressFullscreenManager * configManager = nil;

@interface UKNativeExpressFullscreenManager()<BUNativeExpressFullscreenVideoAdDelegate>

@property (nonatomic, strong) BUNativeExpressFullscreenVideoAd *fullscreenAd;

@property (nonatomic, strong) UIViewController *vc;

@end

@implementation UKNativeExpressFullscreenManager

+(UKNativeExpressFullscreenManager *)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager = [[UKNativeExpressFullscreenManager alloc] init];
    });
    return configManager;
}

- (void)loadExpressAdWithVC:(UIViewController *)vc
{
    if ([UserDefault boolValueForKey:supper_user]) {
        return;
    }
    self.vc = vc;
    self.fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:[HYUKConfigManager shareInstance].versionModel.navexpress_id];
    self.fullscreenAd.delegate = self;
    [self.fullscreenAd loadAdData];
}

/**
 This method is called when video ad material loaded successfully.
 */
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    NSLog(@"nativeExpressFullscreenVideoAdDidLoad");
}

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error
{
    NSLog(@"nativeExpressFullscreenVideoAd");

}

/**
 This method is called when rendering a nativeExpressAdView successed.
 It will happen when ad is show.
 */
- (void)nativeExpressFullscreenVideoAdViewRenderSuccess:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd
{
    NSLog(@"nativeExpressFullscreenVideoAdViewRenderSuccess");

}

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpressFullscreenVideoAdViewRenderFail:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error
{
    NSLog(@"nativeExpressFullscreenVideoAdViewRenderFail");

}

/**
 This method is called when video cached successfully.
 For a better user experience, it is recommended to display video ads at this time.
 And you can call [BUNativeExpressFullscreenVideoAd showAdFromRootViewController:].
 */
- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    [fullscreenVideoAd showAdFromRootViewController:self.vc];
    NSLog(@"nativeExpressFullscreenVideoAdDidDownLoadVideo");

}

/**
 This method is called when video ad slot will be showing.
 */
- (void)nativeExpressFullscreenVideoAdWillVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    NSLog(@"nativeExpressFullscreenVideoAdWillVisible");

}

/**
 This method is called when video ad slot has been shown.
 */
- (void)nativeExpressFullscreenVideoAdDidVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    NSLog(@"nativeExpressFullscreenVideoAdDidVisible");

}

/**
 This method is called when video ad is clicked.
 */
- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    NSLog(@"nativeExpressFullscreenVideoAdDidClick");

}

/**
 This method is called when the user clicked skip button.
 */
- (void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    NSLog(@"nativeExpressFullscreenVideoAdDidClickSkip");

}

/**
 This method is called when video ad is about to close.
 */
- (void)nativeExpressFullscreenVideoAdWillClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    NSLog(@"nativeExpressFullscreenVideoAdWillClose");

}

/**
 This method is called when video ad is closed.
 */
- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    NSLog(@"nativeExpressFullscreenVideoAdDidClose");

}

/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error
{
    NSLog(@"nativeExpressFullscreenVideoAdDidPlayFinish");

}

/**
This method is used to get the type of nativeExpressFullScreenVideo ad
 */
- (void)nativeExpressFullscreenVideoAdCallback:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd withType:(BUNativeExpressFullScreenAdType) nativeExpressVideoAdType
{
    NSLog(@"nativeExpressFullscreenVideoAdCallback");

}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressFullscreenVideoAdDidCloseOtherController:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd interactionType:(BUInteractionType)interactionType
{
    NSLog(@"nativeExpressFullscreenVideoAdDidCloseOtherController");

}

@end
