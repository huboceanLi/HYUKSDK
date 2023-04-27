//
//  HYUkDetailViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkDetailViewController.h"
#import "HYVideoPlayView.h"
#import "HYVideoDetailBriefView.h"
#import "HYVideoDetailToolView.h"
#import "HYVideoDetailSelectWorkView.h"
#import "HYVideoRecommendView.h"
#import "HYVideoBriefDetailView.h"

static CGFloat briefViewHeoght = 60.0;

@interface HYUkDetailViewController ()<HYBaseViewDelegate>

@property(nonatomic, assign) CGFloat playViewHeight;
@property(nonatomic, strong) UIScrollView * scrollView;
@property(nonatomic, strong) HYVideoPlayView * playView;
@property(nonatomic, strong) HYVideoDetailBriefView * briefView;
@property(nonatomic, strong) HYVideoDetailToolView * toolView;
@property(nonatomic, strong) HYVideoDetailSelectWorkView * selectWorkView;
@property(nonatomic, strong) HYVideoRecommendView * recommendView;

@property(nonatomic, strong) HYVideoBriefDetailView * briefDetailView;

@end

@implementation HYUkDetailViewController

- (void)dealloc {
    NSLog(@"HYVideoDetailViewController 灰飞烟灭！");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.clearColor;
    [self.navBackButton setTitle:@"" forState:0];
    
    self.playViewHeight = 220 * SCREEN_WIDTH / 390 + (IS_iPhoneX ? 44 : 24);

    self.playView = [HYVideoPlayView new];
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
    
    self.briefView = [HYVideoDetailBriefView new];
    self.briefView.delegate = self;
    [self.scrollView addSubview:self.briefView];
    
    [self.briefView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(briefViewHeoght);
    }];
    
    self.toolView = [HYVideoDetailToolView new];
    [self.scrollView addSubview:self.toolView];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.briefView.mas_bottom).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(70);
    }];

    self.selectWorkView = [HYVideoDetailSelectWorkView new];
    [self.scrollView addSubview:self.selectWorkView];
    
    self.recommendView = [HYVideoRecommendView new];
    self.recommendView.delegate = self;
    [self.scrollView addSubview:self.recommendView];

    [self.view addSubview:self.briefDetailView];
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    if ([view isKindOfClass:[HYVideoDetailBriefView class]]) {
        self.briefDetailView.hidden = NO;
        self.briefDetailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
        [UIView animateWithDuration:0.2 animations:^{
            self.briefDetailView.frame = CGRectMake(0, self.playViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
        }];
        return;
    }
    
    if ([view isKindOfClass:[HYVideoBriefDetailView class]]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.briefDetailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
        } completion:^(BOOL finished) {
            self.briefDetailView.hidden = YES;
        }];
        return;
    }
    
    if ([view isKindOfClass:[HYVideoRecommendView class]]) {
//        HYMovieListItemModel *model = event;
//
//        HYWebVideoViewController *vc = [HYWebVideoViewController new];
//        vc.movieModel = model;
//        vc.list = self.list;
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
