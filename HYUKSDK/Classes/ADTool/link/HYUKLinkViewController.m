//
//  HYUKLinkViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/19.
//

#import "HYUKLinkViewController.h"
#import "LHYReachability.h"
#import "HYUkRequestWorking.h"
#import "HYVideoVersionModel.h"
#import "HYUKConfigManager.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>

#import "UKBuSplashManager.h"


@interface HYUKLinkViewController ()

@property (nonatomic) LHYReachability *hostReachability;
@property (nonatomic) HYVideoVersionModel *versionModel;
@property (nonatomic, strong) UIImageView *bgImageView;
//@property (copy, nonatomic) void (^rootVC)(BOOL rootVC);

@end

@implementation HYUKLinkViewController

- (void)dealloc {
    NSLog(@"HYUKLinkViewController dealloc");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;

    if ([HYUKConfigManager shareInstance].linkImage) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:[HYUKConfigManager shareInstance].linkRect];
        bgImageView.image = [HYUKConfigManager shareInstance].linkImage;
        bgImageView.clipsToBounds = YES;
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:bgImageView];
        self.bgImageView = bgImageView;
    }
    
    self.hostReachability = [LHYReachability reachabilityWithHostName:@"https://www.baidu.com"];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (@available(iOS 14, *)) {
            //申请权限
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                NSLog(@"IDFA:%@",[[ASIdentifierManager sharedManager] advertisingIdentifier]);
            }];
        }
    });
}

- (void)updateInterfaceWithReachability:(LHYReachability *)reachability{
    if (reachability == self.hostReachability){
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        switch (netStatus){
            case NotReachable: {
                NSLog(@"ViewController : 没有网络！");
                break;
            }
            case ReachableViaWWAN: {
                
                NSLog(@"ViewController : 4G/3G");
                [self showLinkAd];
                [self.hostReachability stopNotifier];
                break;
            }
            case ReachableViaWiFi: {
                NSLog(@"ViewController : WiFi");
                [self showLinkAd];
                [self.hostReachability stopNotifier];
                break;
            }
        }
    }
}

//- (void)showViewControllerRootVC:(void (^)(BOOL rootVC))rootVC
//{
//    self.rootVC = rootVC;
//}

- (void)showLinkAd {
    __weak typeof(self) weakSelf = self;
    [HYUkRequestWorking getVersionCompletionHandle:^(HYVideoVersionModel * _Nonnull model, BOOL success) {
        if (success) {
            weakSelf.versionModel = model;
            [weakSelf chooseModel];
        }else {
            //去业务
            weakSelf.successBlock(NO);
//            weakSelf.rootVC(NO);
        }
    }];
}

- (void)chooseModel {
    if ([self.versionModel.version integerValue] == 9999 || !self.versionModel.open_ad) {
//        self.rootVC(NO);
        self.successBlock(NO);
        return;
    }

    //初始化广告，调用开屏
    [[UKBuSplashManager shared] registerAppId];

    __weak typeof(self) weakSelf = self;
    [[UKBuSplashManager shared] loadSplashAdWithVC:self close:^(BOOL close) {
        [weakSelf p_dismiss];
        weakSelf.successBlock(NO);
    }];

}

- (void)p_dismiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
