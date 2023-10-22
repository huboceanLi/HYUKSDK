//
//  HYUkDetailViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkDetailViewController.h"
#import "HYUkVideoPlayView.h"
#import "HYUkVideoDetailBriefView.h"
#import "HYUkVideoDetailSelectWorkView.h"
#import "HYUkVideoRecommendView.h"
#import "HYUkVideoBriefDetailView.h"
#import "HYUkHeader.h"
#import "HYUkDetailErrorView.h"
#import "HYResponseRecommendModel.h"
#import "HYUkAllGatherListView.h"
#import "HYUkDownGatherView.h"

static CGFloat briefViewHeoght = 60.0;

static NSInteger allTime = 31;

@interface HYUkDetailViewController ()<HYBaseViewDelegate>

@property(nonatomic, assign) CGFloat playViewHeight;
@property(nonatomic, strong) UIScrollView * scrollView;
@property(nonatomic, strong) HYUkVideoPlayView * playView;
@property(nonatomic, strong) HYUkVideoDetailBriefView * briefView;
@property(nonatomic, strong) HYUkVideoDetailSelectWorkView * selectWorkView;
@property(nonatomic, strong) HYUkVideoRecommendView * recommendView;
@property(nonatomic, strong) HYUkVideoBriefDetailView * briefDetailView;
@property(nonatomic, strong) HYUkVideoDetailModel * detailModel;
@property(nonatomic, strong) HYUkDetailErrorView * errorView;
@property(nonatomic, strong) HYUkAllGatherListView * gatherListView;
@property(nonatomic, strong) HYUkDownGatherView * downGatherView;
//@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) UIButton *timeButton;
//@property (nonatomic, assign) NSInteger recordIndex;
//@property (nonatomic, strong) UIView *tempView;

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation HYUkDetailViewController

- (void)dealloc {
    [self.playView removeView];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"HYVideoDetailViewController 灰飞烟灭！");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    [self closeAddButton];
    
    [self.playView saveHistoryRecord];
    
    if ([self.delegate respondsToSelector:@selector(changeVideoProgressVideoId:)]) {
        [self.delegate changeVideoProgressVideoId:self.videoId];
    }
    
//    [[HYUkVideoConfigManager sharedInstance] setChangeOrientation:NO];
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIInterfaceOrientationPortrait;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
}

- (void)clickedBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navBar.backgroundColor = UIColor.clearColor;
//    [self.navBackButton setTitle:@"" forState:0];
    briefViewHeoght = XJFlexibleFont(60.0);
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(0, (IS_iPhoneX?48:24), 40, 40);
    [self.backButton addTarget:self action:@selector(clickedBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setImage:[UIImage uk_bundleImage:@"p_back"] forState:UIControlStateNormal];
    [self.view addSubview:self.backButton];
    
    
    self.playViewHeight = 220 * SCREEN_WIDTH / 390 + (IS_iPhoneX ? 44 : 24);

    self.playView = [HYUkVideoPlayView new];
    self.playView.delegate = self;
    [self.view addSubview:self.playView];

    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_offset(self.playViewHeight);
    }];
    
//    [self.view bringSubviewToFront:self.navBar];
    [self.view bringSubviewToFront:self.backButton];

    self.scrollView = [UIScrollView new];
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0, *)) {
        [self.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playView.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];

    self.briefView = [HYUkVideoDetailBriefView new];
    self.briefView.delegate = self;
    [self.scrollView addSubview:self.briefView];
    
    [self.briefView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(briefViewHeoght);
    }];
    
//    self.toolView = [HYUkVideoDetailToolView new];
//    self.toolView.delegate = self;
//    [self.scrollView addSubview:self.toolView];
//    
//    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.briefView.mas_bottom).offset(0);
//        make.left.equalTo(self.scrollView);
//        make.width.mas_offset(SCREEN_WIDTH);
//        make.height.mas_offset(XJFlexibleFont(70));
//    }];

    self.selectWorkView = [HYUkVideoDetailSelectWorkView new];
    self.selectWorkView.delegate = self;
    [self.scrollView addSubview:self.selectWorkView];
    
    [self.selectWorkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.briefView.mas_bottom).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(XJFlexibleFont(100.0));
    }];
    
    self.recommendView = [HYUkVideoRecommendView new];
    self.recommendView.delegate = self;
    [self.scrollView addSubview:self.recommendView];

    [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectWorkView.mas_bottom).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(XJFlexibleFont(186));
        make.bottom.equalTo(self.scrollView).offset(-(IS_iPhoneX ? 34 : 20));
    }];
    
    [self.view addSubview:self.briefDetailView];

    self.briefDetailView.hidden = YES;
    
    [self.view addSubview:self.gatherListView];

    self.gatherListView.hidden = YES;
    
    [self.view addSubview:self.downGatherView];

    self.downGatherView.hidden = YES;
    
    self.scrollView.hidden = YES;
    
    [self.view addSubview:self.errorView];
    self.errorView.hidden = YES;
    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.playView.mas_bottom).offset(0);
    }];
    
    //监听程序进入前台和后台
     [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(enterBackGround:)
                                                  name:UIApplicationDidEnterBackgroundNotification
                                                object:nil];
    [self getData];

}


- (void)enterBackGround:(NSNotificationCenter *)notification
{
    [self.playView saveHistoryRecord];
}

- (void)getData {
    __weak typeof(self) weakSelf = self;
    [[HYUkShowLoadingManager sharedInstance] showLoading:-1];
    [[HYVideoSingle sharedInstance] getVideoDetaildID:self.videoId success:^(NSString *message, id responseObject) {
        weakSelf.detailModel = responseObject;
        weakSelf.scrollView.hidden = NO;
        weakSelf.briefView.data = responseObject;
        [weakSelf.briefView loadContent];
        
        weakSelf.briefDetailView.data = responseObject;
        [weakSelf.briefDetailView loadContent];
        
        weakSelf.selectWorkView.data = responseObject;
        [weakSelf.selectWorkView loadContent];
        
        weakSelf.playView.data = responseObject;
        [weakSelf.playView loadContent];

        [weakSelf getGuessLikeList];
        
        weakSelf.gatherListView.data = responseObject;
        [weakSelf.gatherListView loadContent];
        
        weakSelf.downGatherView.data = responseObject;
        [weakSelf.downGatherView loadContent];
        
        [weakSelf.playView startPlay];
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        self.errorView.hidden = NO;
        if (errorType == CTAPIManagerErrorTypeNoNetWork) {
            [weakSelf.errorView showImageName:@"uk_net_err" TitleString:@"无网络连接，请检查网络"];
        }else {
            [weakSelf.errorView showImageName:@"uk_load_err" TitleString:@"加载失败!"];
        }
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
    }];
}

- (void)getGuessLikeList {
    __weak typeof(self) weakSelf = self;
    [[HYVideoSingle sharedInstance] getGuessLikeListWithCurrentVideoId:self.videoId success:^(NSString *message, id responseObject) {
        
        weakSelf.recommendView.data = responseObject;
        [weakSelf.recommendView loadContent];
        
        [[HYUkShowLoadingManager sharedInstance] removeLoading];

    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
    }];
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    if ([view isKindOfClass:[HYUkVideoDetailBriefView class]]) {
        self.briefDetailView.hidden = NO;
        self.briefDetailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
        [UIView animateWithDuration:0.2 animations:^{
            self.briefDetailView.frame = CGRectMake(0, self.playViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
        }];
        return;
    }
    
    if ([view isKindOfClass:[HYUkVideoBriefDetailView class]]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.briefDetailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
        } completion:^(BOOL finished) {
            self.briefDetailView.hidden = YES;
        }];
        return;
    }
    
    if ([view isKindOfClass:[HYUkVideoRecommendView class]]) {
        BOOL isOpenTheProxy = [[HYUkVideoConfigManager sharedInstance] isOpenTheProxy];
        if (isOpenTheProxy) {
            [MYToast showWithText:@"请关闭设备代理,否则会播放失败!"];
            return;
        }
        
        HYResponseRecommendModel *model = event;
        HYUkDetailViewController *vc = [HYUkDetailViewController new];
        vc.videoId = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
        
        NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
        
        for (UIViewController *item in vcs) {
            if ([item isKindOfClass:[HYUkDetailViewController class]]) {
                [vcs removeObject:item];
                self.navigationController.viewControllers = vcs;
                break;
            }
        }
    }

    if ([view isKindOfClass:[HYUkDownGatherView class]]) {
        NSDictionary *dic = event;
        if ([dic[@"type"] isEqualToString:@"close"]) {
            [UIView animateWithDuration:0.2 animations:^{
                self.downGatherView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
            } completion:^(BOOL finished) {
                self.downGatherView.hidden = YES;
            }];
            return;
        }
        return;
    }
    
    if ([view isKindOfClass:[HYUkVideoDetailSelectWorkView class]]) {
        

        [[YXTypeManager shareInstance] showAdWithType:FromWayType_Unknown complete:^(BOOL result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dic = event;
                if ([dic[@"type"] isEqualToString:@"more"]) {
                    self.gatherListView.hidden = NO;
                    self.gatherListView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
                    [UIView animateWithDuration:0.2 animations:^{
                        self.gatherListView.frame = CGRectMake(0, self.playViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
                    }];
                    return;
                }
                [self.playView changeSelect:dic[@"name"] Url:dic[@"url"]];
            });
        }];
        

        return;
    }
    
    if ([view isKindOfClass:[HYUkAllGatherListView class]]) {
        NSDictionary *dic = event;
        if ([dic[@"type"] isEqualToString:@"close"]) {
            [UIView animateWithDuration:0.2 animations:^{
                self.gatherListView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
            } completion:^(BOOL finished) {
                self.gatherListView.hidden = YES;
            }];
            return;
        }
        [self.playView changeSelect:dic[@"name"] Url:dic[@"url"]];
        return;
    }
    
    if ([view isKindOfClass:[HYUkVideoPlayView class]]) {
        [self.selectWorkView changeSelect:event];
        [self.gatherListView changeSelect:event];
        return;
    }
}

- (HYUkVideoBriefDetailView *)briefDetailView {
    if (!_briefDetailView) {
        _briefDetailView = [HYUkVideoBriefDetailView new];
        _briefDetailView.delegate = self;
    }
    return _briefDetailView;
}

- (HYUkDetailErrorView *)errorView {
    if (!_errorView) {
        _errorView = [HYUkDetailErrorView new];
    }
    return _errorView;
}

- (HYUkAllGatherListView *)gatherListView {
    if (!_gatherListView) {
        _gatherListView = [HYUkAllGatherListView new];
        _gatherListView.delegate = self;
    }
    return _gatherListView;
}

- (HYUkDownGatherView *)downGatherView {
    if (!_downGatherView) {
        _downGatherView = [HYUkDownGatherView new];
        _downGatherView.delegate = self;
    }
    return _downGatherView;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//#pragma BUNativeExpressAdViewDelegate
//- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray
//{
//    NSLog(@"nativeAdsManagerSuccessToLoad : %@", nativeAdDataArray);
//
//}
//
//- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error
//{
//    NSLog(@"didFailWithError : %@", error);
//    [self closeAddButton];
//}
///**
// * Sent when views successfully load ad
// */
//- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views
//{
//    [self.expressAdViews removeAllObjects];
//    self.expressAdView = nil;
//    
//    if (views.count) {
//
//        [self.expressAdViews addObjectsFromArray:views];
////        [self.expressAdViews addObject:views.firstObject];
//        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
//            expressView.rootViewController = self;
//            // important: 此处会进行WKWebview的渲染，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
//            [expressView render];
//            *stop = YES;
//        }];
//
//        if (self.expressAdViews.count > 0) {
//            
//            self.expressAdView = self.expressAdViews.firstObject;
//            self.expressAdView.frame = CGRectMake(0, IS_iPhoneX ?  44 : 20, SCREEN_WIDTH, self.playViewHeight - (IS_iPhoneX ?  44 : 20));
//            [self.view addSubview:self.expressAdView];
//            [self.view bringSubviewToFront:self.backButton];
//        }
//    }else {
//        [self closeAddButton];
//    }
//    NSLog(@"nativeExpressAdSuccessToLoad");
//
//}
//
///**
// * Sent when views fail to load ad
// */
//- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager error:(NSError *_Nullable)error
//{
//    NSLog(@"nativeExpressAdFailToLoad : %@", error);
//    [self closeAddButton];
//}
//
///**
// * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
// */
//- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView
//{
//    NSLog(@"nativeExpressAdViewRenderSuccess");
//
//}
//
///**
// * This method is called when a nativeExpressAdView failed to render
// */
//- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error
//{
//    NSLog(@"nativeExpressAdViewRenderFail");
//
//}
//
///**
// * Sent when an ad view is about to present modal content
// */
//- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView
//{
//    NSLog(@"nativeExpressAdViewWillShow");
//    self.timeButton.hidden = NO;
//    self.timeButton.userInteractionEnabled = NO;
//    self.recordIndex = allTime;
//    [self.timer setFireDate:[NSDate date]];
//    [self.view bringSubviewToFront:self.timeButton];
//    [self.playView pause];
//    self.playView.hidden = YES;
//}
//
///**
// * Sent when an ad view is clicked
// */
//- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView
//{
//    NSLog(@"nativeExpressAdViewDidClick");
//
//}
//
///**
//Sent when a playerw playback status changed.
//@param playerState : player state after changed
//*/
//- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState
//{
//    NSLog(@"nativeExpressAdView");
//
//}
//
///**
// * Sent when a player finished
// * @param error : error of player
// */
//- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error
//{
//    NSLog(@"nativeExpressAdViewPlayerDidPlayFinish");
//
//}
//
///**
// * Sent when a user clicked dislike reasons.
// * @param filterWords : the array of reasons why the user dislikes the ad
// */
//- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords
//{
//    NSLog(@"nativeExpressAdView");
//
//}
//
///**
// * Sent after an ad view is clicked, a ad landscape view will present modal content
// */
//- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView
//{
//    NSLog(@"nativeExpressAdViewWillPresentScreen");
//
//}
//
///**
// This method is called when another controller has been closed.
// @param interactionType : open appstore in app or open the webpage or view video ad details page.
// */
//- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType
//{
//    NSLog(@"nativeExpressAdViewDidCloseOtherController");
//
//}
//
//
///**
// This method is called when the Ad view container is forced to be removed.
// @param nativeExpressAdView : Ad view container
// */
//- (void)nativeExpressAdViewDidRemoved:(BUNativeExpressAdView *)nativeExpressAdView
//{
//    NSLog(@"nativeExpressAdViewDidRemoved");
//}


@end
