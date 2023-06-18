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
#import "HYUKSDK/HYUKSDK-Swift.h"
#import "UKBuSplashManager.h"
#import "HYUkHeader.h"


@interface HYUKLinkViewController ()

@property (nonatomic) LHYReachability *hostReachability;
@property (nonatomic) HYVideoVersionModel *versionModel;
@property (nonatomic, strong) UIImageView *bgImageView;
//@property (copy, nonatomic) void (^rootVC)(BOOL rootVC);
@property (nonatomic, strong) QMUIButton *netButton;

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
    
    self.netButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.netButton setTitle:@"没有网络,请开启网路权限!" forState:0];
    [self.netButton setTitleColor:[UIColor qmui_colorWithHexString:@"#8a8a8a"] forState:0];
    self.netButton.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(16)];
    [self.netButton setImage:[UIImage uk_bundleImage:@"uk_net_errror"] forState:0];
    [self.netButton setImagePosition:QMUIButtonImagePositionTop];
    self.netButton.spacingBetweenImageAndTitle = XJFlexibleFont(20);
    [self.view addSubview:self.netButton];
    [self.netButton addTarget:self action:@selector(netButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.netButton.hidden = YES;
    
    [self.netButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
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

- (void)netButtonClick {
    [self showLinkAd];
}

- (void)updateInterfaceWithReachability:(LHYReachability *)reachability{
    if (reachability == self.hostReachability){
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        switch (netStatus){
            case NotReachable: {
                self.netButton.hidden = NO;
                [self.netButton setTitle:@"没有网络,请开启网路权限!" forState:0];
                NSLog(@"ViewController : 没有网络！");
                break;
            }
            case ReachableViaWWAN: {
                self.netButton.hidden = YES;
                NSLog(@"ViewController : 4G/3G");
                [self showLinkAd];
                [self.hostReachability stopNotifier];
                break;
            }
            case ReachableViaWiFi: {
                self.netButton.hidden = YES;
                NSLog(@"ViewController : WiFi");
                [self showLinkAd];
                [self.hostReachability stopNotifier];
                break;
            }
        }
    }
}

- (void)showLinkAd {

    __weak typeof(self) weakSelf = self;
    [HYUkRequestWorking getVersionCompletionHandle:^(HYVideoVersionModel * _Nonnull model, BOOL success) {
        if (success) {
            weakSelf.versionModel = model;
            [HYUKConfigManager shareInstance].versionModel = model;
            [weakSelf chooseModel];
        }else {
            //去业务
            [weakSelf.netButton setTitle:@"网络错误,请稍后重试!" forState:0];
            weakSelf.netButton.hidden = NO;
        }
    }];
}

- (void)chooseModel {
    
    if (self.versionModel == nil || !self.versionModel.open_ad) {
        self.successBlock(YES);
        return;
    }

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    if ([app_build integerValue] <=  [self.versionModel.version integerValue]) {
        //初始化广告，调用开屏
        __weak typeof(self) weakSelf = self;
        [[UKBuSplashManager shared] registerAppIdSuccess:^(BOOL initSuccess) {
            if (initSuccess) {
                [[UKBuSplashManager shared] loadSplashAdWithVC:self close:^(BOOL close) {
                    [weakSelf p_dismiss];
                    weakSelf.successBlock(NO);
                }];
            }else {
                weakSelf.successBlock(NO);
            }
        }];

        
        return;
    }
    self.successBlock(YES);
}

- (void)p_dismiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
