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

@property(nonatomic, strong) UIView * adView;

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
}

- (void)clickedBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

    self.adView = [UIView new];
    self.adView.backgroundColor = UIColor.clearColor;
    [self.scrollView addSubview:self.adView];
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.briefView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(0.0);
    }];
    
    self.selectWorkView = [HYUkVideoDetailSelectWorkView new];
    self.selectWorkView.delegate = self;
    [self.scrollView addSubview:self.selectWorkView];
    
    [self.selectWorkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adView.mas_bottom).offset(0);
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
        

        [[YXTypeManager shareInstance] showBannerAdComplete:^(BOOL complete, UIView * adView) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    
                    if (adView) {
                        weakSelf.adView.hidden = NO;
                        [weakSelf.adView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.mas_offset(120.0);
                        }];
                        [weakSelf.adView addSubview:adView];
                    }else {
                        weakSelf.adView.hidden = YES;
                        [weakSelf.adView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.mas_offset(0.0);
                        }];
                    }
                }else {
                    weakSelf.adView.hidden = YES;
                    [weakSelf.adView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_offset(0.0);
                    }];
                }
            });
        }];
        
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
        
        __weak typeof(self) weakSelf = self;

        [[YXTypeManager shareInstance] showAdWithType:FromWayType_Unknown complete:^(BOOL result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dic = event;
                if ([dic[@"type"] isEqualToString:@"more"]) {
                    weakSelf.gatherListView.hidden = NO;
                    weakSelf.gatherListView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - weakSelf.playViewHeight);
                    [UIView animateWithDuration:0.2 animations:^{
                        weakSelf.gatherListView.frame = CGRectMake(0, weakSelf.playViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - weakSelf.playViewHeight);
                    }];
                    return;
                }
                [weakSelf.playView changeSelect:dic[@"name"] Url:dic[@"url"]];
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

@end
