//
//  UKExpressAdManager.m
//  HYUKADSDK
//
//  Created by Ocean 李 on 2023/6/4.
//

#import "UKExpressAdManager.h"
#import "HYUKConfigManager.h"
#import "HYExpressAdView.h"

static UKExpressAdManager * configManager = nil;


@interface UKExpressAdManager()<BUNativeExpressAdViewDelegate,HYExpressAdViewDelegate>

@property (nonatomic, strong) BUNativeExpressAdManager *nativeExpressAdManager;
@property (strong, nonatomic) NSMutableArray<__kindof BUNativeExpressAdView *> *expressAdViews;
@property (copy, nonatomic) void (^show)(void);
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, strong) UIButton *timeButton;

@property (nonatomic, strong) HYExpressAdView *expressAdView;

@end

@implementation UKExpressAdManager

- (HYExpressAdView *)expressAdView {
    if (!_expressAdView) {
        _expressAdView = [[HYExpressAdView alloc] initWithFrame:CGRectZero];
        _expressAdView.delegate = self;
    }
    return _expressAdView;
}

- (void)customView:(HYExpressAdView *)view event:(id)event
{
    [self closeAddButton];
}

+(UKExpressAdManager *)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager = [[UKExpressAdManager alloc] init];
        configManager.expressAdViews = [NSMutableArray array];
    });
    return configManager;
}



- (void)closeAddButton {
    [self.expressAdViews removeAllObjects];
    self.show();
}

- (void)loadExpressAdWithVC:(UIViewController *)vc rect:(CGRect)rect show:(void (^)(void))show
{
    self.show = show;
    self.rect = rect;
    self.vc = vc;
    [self registerAppId];
}

- (void)registerAppId {
    
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = [HYUKConfigManager shareInstance].ADIDModel.buRewardedId;
    slot1.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Banner600_150];
    slot1.imgSize = imgSize;
    slot1.position = BUAdSlotPositionFeed;
    // self.nativeExpressAdManager可以重用
     if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0)];
        }
    self.nativeExpressAdManager.adSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    self.nativeExpressAdManager.delegate = self;
    [self.nativeExpressAdManager loadAdDataWithCount:1];
}

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray
{
    NSLog(@"nativeAdsManagerSuccessToLoad : %@", nativeAdDataArray);

}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error
{
    NSLog(@"didFailWithError : %@", error);

}
/**
 * Sent when views successfully load ad
 */
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views
{
    [self.expressAdViews removeAllObjects];
    [self.expressAdView removeFromSuperview];
    self.expressAdView = nil;
    
    if (views.count) {

        [self.expressAdViews addObjectsFromArray:views];
//        [self.expressAdViews addObject:views.firstObject];
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
            expressView.rootViewController = self.vc;
            // important: 此处会进行WKWebview的渲染，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
            [expressView render];
            *stop = YES;
        }];
        
        self.expressAdView.frame = self.rect;
        [self.vc.view addSubview:self.expressAdView];

        if (self.expressAdViews.count > 0) {
            
            BUNativeExpressAdView *v = self.expressAdViews.firstObject;
            [self.expressAdView addSubview:v];
        }
    }
    NSLog(@"nativeExpressAdSuccessToLoad");

}

/**
 * Sent when views fail to load ad
 */
- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager error:(NSError *_Nullable)error
{
    NSLog(@"nativeExpressAdFailToLoad : %@", error);

}

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"nativeExpressAdViewRenderSuccess");

}

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error
{
    NSLog(@"nativeExpressAdViewRenderFail");

}

/**
 * Sent when an ad view is about to present modal content
 */
- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"nativeExpressAdViewWillShow");
    [self.expressAdView showAd];

}

/**
 * Sent when an ad view is clicked
 */
- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"nativeExpressAdViewDidClick");

}

/**
Sent when a playerw playback status changed.
@param playerState : player state after changed
*/
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState
{
    NSLog(@"nativeExpressAdView");

}

/**
 * Sent when a player finished
 * @param error : error of player
 */
- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error
{
    NSLog(@"nativeExpressAdViewPlayerDidPlayFinish");

}

/**
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords
{
    NSLog(@"nativeExpressAdView");

}

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"nativeExpressAdViewWillPresentScreen");

}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType
{
    NSLog(@"nativeExpressAdViewDidCloseOtherController");

}


/**
 This method is called when the Ad view container is forced to be removed.
 @param nativeExpressAdView : Ad view container
 */
- (void)nativeExpressAdViewDidRemoved:(BUNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"nativeExpressAdViewDidRemoved");
}

@end
