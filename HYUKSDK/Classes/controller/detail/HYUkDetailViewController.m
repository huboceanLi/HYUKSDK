//
//  HYUkDetailViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkDetailViewController.h"
#import "HYUkVideoPlayView.h"
#import "HYUkVideoDetailBriefView.h"
#import "HYUkVideoDetailToolView.h"
#import "HYUkVideoDetailSelectWorkView.h"
#import "HYUkVideoRecommendView.h"
#import "HYUkVideoBriefDetailView.h"
#import "HYUkHeader.h"
#import "HYUkDetailErrorView.h"

static CGFloat briefViewHeoght = 60.0;

@interface HYUkDetailViewController ()<HYBaseViewDelegate>

@property(nonatomic, assign) CGFloat playViewHeight;
@property(nonatomic, strong) UIScrollView * scrollView;
@property(nonatomic, strong) HYUkVideoPlayView * playView;
@property(nonatomic, strong) HYUkVideoDetailBriefView * briefView;
@property(nonatomic, strong) HYUkVideoDetailToolView * toolView;
@property(nonatomic, strong) HYUkVideoDetailSelectWorkView * selectWorkView;
@property(nonatomic, strong) HYUkVideoRecommendView * recommendView;
@property(nonatomic, strong) HYUkVideoBriefDetailView * briefDetailView;
@property(nonatomic, strong) HYUkVideoDetailModel * detailModel;
@property(nonatomic, strong) HYUkDetailErrorView * errorView;



@end

@implementation HYUkDetailViewController

- (void)dealloc {
    NSLog(@"HYVideoDetailViewController 灰飞烟灭！");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [[HYUkConfigManager sharedInstance] setChangeOrientation:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.playView saveHistoryRecord];
    
    if ([self.delegate respondsToSelector:@selector(changeVideoProgressVideoId:)]) {
        [self.delegate changeVideoProgressVideoId:self.videoId];
    }
    
    [[HYUkConfigManager sharedInstance] setChangeOrientation:NO];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.clearColor;
    [self.navBackButton setTitle:@"" forState:0];
    
    
    self.playViewHeight = 220 * SCREEN_WIDTH / 390 + (IS_iPhoneX ? 44 : 24);

    self.playView = [HYUkVideoPlayView new];
    self.playView.delegate = self;
    [self.view addSubview:self.playView];

    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_offset(self.playViewHeight);
    }];
    
    [self.view bringSubviewToFront:self.navBar];
    
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
    
    self.toolView = [HYUkVideoDetailToolView new];
    self.toolView.delegate = self;
    [self.scrollView addSubview:self.toolView];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.briefView.mas_bottom).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(70);
    }];

    self.selectWorkView = [HYUkVideoDetailSelectWorkView new];
    self.selectWorkView.delegate = self;
    [self.scrollView addSubview:self.selectWorkView];
    
    [self.selectWorkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolView.mas_bottom).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(100);
    }];
    
    self.recommendView = [HYUkVideoRecommendView new];
    self.recommendView.delegate = self;
    [self.scrollView addSubview:self.recommendView];

    [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectWorkView.mas_bottom).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(120);
        make.bottom.equalTo(self.scrollView).offset(-(IS_iPhoneX ? 34 : 20));
    }];
    
    [self.view addSubview:self.briefDetailView];

    self.briefDetailView.hidden = YES;
    
    self.scrollView.hidden = YES;
    
    [self.view addSubview:self.errorView];
    self.errorView.hidden = YES;
    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.playView.mas_bottom).offset(0);
    }];
    
    [self getData];
}

- (void)getData {
    __weak typeof(self) weakSelf = self;
    [[HYUkShowLoadingManager sharedInstance] showLoading];
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

        weakSelf.toolView.data = responseObject;
        [weakSelf.toolView loadContent];
        
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
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
//        HYMovieListItemModel *model = event;
//
//        HYWebVideoViewController *vc = [HYWebVideoViewController new];
//        vc.movieModel = model;
//        vc.list = self.list;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([view isKindOfClass:[HYUkVideoDetailToolView class]]) {
        NSDictionary *dic = event;
        NSInteger videoId = [dic[@"videoID"] integerValue];
        if ([self.delegate respondsToSelector:@selector(changeLikeStatus:videoId:)]) {
            [self.delegate changeLikeStatus:[dic[@"isLike"] boolValue] videoId:videoId];
        }
    }
    
    if ([view isKindOfClass:[HYUkVideoDetailSelectWorkView class]]) {
        NSDictionary *dic = event;
        [self.playView changeSelect:dic[@"name"] Url:dic[@"url"]];
    }
    
    
    if ([view isKindOfClass:[HYUkVideoPlayView class]]) {
        [self.selectWorkView changeSelect:event];
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

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
