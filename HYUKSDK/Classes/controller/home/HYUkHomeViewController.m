//
//  HYUkHomeViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkHomeViewController.h"
#import "HYUkOtherViewController.h"
#import "HYUkSearchViewController.h"
#import "HYUkHomeSearchView.h"
#import "HYUKSDK/HYUKSDK-Swift.h"
#import "HYUkDetailViewController.h"
#import "HYUKHistoryRecodeView.h"
#import "HYUkCenterHistoryListViewController.h"
#import "HYUKRecommendViewController.h"

@interface HYUkHomeViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate, HYBaseViewDelegate,PopViewControllerDelegate>

@property(nonatomic, strong) JXCategoryTitleView * headerView;
@property(nonatomic, strong) JXCategoryListContainerView * containerView;
@property(nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) HYUkHomeSearchView *searchView;
@property (nonatomic, strong) UIButton *historyBtn;
@property (nonatomic, strong) NSArray *categeryModels;
@property (nonatomic, strong) HYUKHistoryRecodeView *recodeView;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation HYUkHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
    [self getHistory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navBar.backgroundColor = UIColor.clearColor;
    self.bgImageView = [UIImageView new];
    self.bgImageView.image = [UIImage uk_bundleImage:@"uk_bg_Img"];
    [self.view addSubview:self.bgImageView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    [[HYVideoDBLogic share] initDB];
    [[HYUkVideoConfigManager sharedInstance] startNetworkMonitoring];
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-62);
//        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.top.equalTo(self.view.mas_top).offset(NAV_HEIGHT - 40);
        make.height.mas_equalTo(40);
    }];
//    
    [self.view addSubview:self.historyBtn];
    [self.historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(NAV_HEIGHT - 40);
        make.height.width.mas_equalTo(40);
    }];
    
    _headerView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = UIColor.clearColor;
    _headerView.titles = _titleArray;
    _headerView.titleColor = UIColor.textColor22;
    _headerView.titleSelectedColor = UIColor.whiteColor;
    
    _headerView.titleSelectedFont = [UIFont boldSystemFontOfSize:XJFlexibleFont(16)];
    _headerView.titleFont = UIFontMake(XJFlexibleFont(14));
    _headerView.titleColorGradientEnabled = YES;
    _headerView.titleLabelZoomScale = 1.1;
    _headerView.titleLabelZoomEnabled = YES;
    _headerView.cellWidth = 60;
    _headerView.cellSpacing = 12;
//    _headerView.qmui_borderPosition = QMUIViewBorderPositionBottom;
    _headerView.delegate = self;
    [self.view addSubview:_headerView];

    _containerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    _containerView.listCellBackgroundColor = [UIColor clearColor];
    _containerView.scrollView.backgroundColor = UIColor.clearColor;
    _containerView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:_containerView];
    _headerView.listContainer = _containerView;

    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAV_HEIGHT);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(IS_IPAD ? 60 : 40);
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    BOOL isOpenTheProxy = [[HYUkVideoConfigManager sharedInstance] isOpenTheProxy];
    if (isOpenTheProxy) {
        [MYToast showWithText:@"请关闭设备代理,否则会播放失败!" inView:self.view hideAfterDelay:10.0];
    }
    
    [self getData];

    [self.view addSubview:self.recodeView];
    [self.recodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(- (IS_IPAD ? 150 : (IS_iPhoneX ? 120 : 80)));
        make.height.mas_equalTo(XJFlexibleFont(60));
    }];
    
    self.recodeView.hidden = YES;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[YXTypeManager shareInstance] showAdWithType:FromWayType_Unknown complete:^(BOOL result) {
                
        }];
    });
}

- (void)getHistory {
    NSArray *arr = [[HYUkHistoryRecordLogic share] queryHistoryRecordListWithCreateTime:NSIntegerMax count:1];
    if (arr.count > 0) {
        HYUkHistoryRecordModel *m = arr.firstObject;
        
        if (m.duration - m.playDuration < 120) {
            self.recodeView.hidden = YES;
        }else {
            self.recodeView.hidden = NO;
            self.recodeView.data = m;
            [self.recodeView loadContent];
        }
    }else {
        self.recodeView.hidden = YES;
    }
}

- (void)getData {
    __weak typeof(self) weakSelf = self;
    [[HYVideoSingle sharedInstance] categeryWithListSuccess:^(NSString *message, id responseObject) {
        weakSelf.categeryModels = responseObject;
        
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:@"推荐"];
        for (HYResponseCategeryModel *itemModel in weakSelf.categeryModels) {
            [arr addObject:itemModel.name];
        }
        weakSelf.titleArray = [arr mutableCopy];
        weakSelf.headerView.titles = weakSelf.titleArray;
        [weakSelf.headerView reloadData];
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
    }];
}

#pragma mark-- <JXCategoryListContainerViewDelegate>
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        HYUKRecommendViewController * listVC = [[HYUKRecommendViewController alloc] init];
        return listVC;
    }
    HYUkOtherViewController * listVC = [[HYUkOtherViewController alloc] init];
    listVC.index = index;
    listVC.categeryModel = self.categeryModels[index - 1];
    
    return listVC;

}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return _titleArray.count;
}

- (HYUkHomeSearchView *)searchView {
    if (!_searchView) {
        _searchView = [HYUkHomeSearchView new];
        _searchView.delegate = self;
    }
    return _searchView;
}

- (HYUKHistoryRecodeView *)recodeView {
    if (!_recodeView) {
        _recodeView = [HYUKHistoryRecodeView new];
        _recodeView.delegate = self;
    }
    return _recodeView;
}

- (void)customView:(HYBaseView *)view event:(id)event{
    if ([view isKindOfClass:[HYUkHomeSearchView class]]) {
        HYUkSearchViewController *vc = [HYUkSearchViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ([view isKindOfClass:[HYUKHistoryRecodeView class]]) {
        HYUkHistoryRecordModel *m = view.data;
        HYUkDetailViewController *vc = [HYUkDetailViewController new];
        vc.videoId = m.tvId;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
//    if ([view isKindOfClass:[HYUKBadgeView class]]) {
//        HYUKMessageViewController *vc = [HYUKMessageViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
//        return;
//    }
}

- (void)hisetoryButtonClick {
    [self.navigationController pushViewController:[HYUkCenterHistoryListViewController new] animated:YES];
}

- (UIButton *)historyBtn {
    if (!_historyBtn) {
        _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_historyBtn setImage:[UIImage uk_bundleImage:@"uk_message"] forState:0];
        [_historyBtn addTarget:self action:@selector(hisetoryButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _historyBtn;
}

- (void)popViewController:(PopViewController *)popVC event:(id)event
{
    
}
@end
