//
//  HYUkHomeViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkHomeViewController.h"
#import "HYUkOtherViewController.h"
#import "HYUkRecommendVC.h"
#import "HYUkSearchViewController.h"
#import "HYUkHomeSearchView.h"

@interface HYUkHomeViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate, HYBaseViewDelegate>

@property(nonatomic, strong) JXCategoryTitleView * headerView;
@property(nonatomic, strong) JXCategoryListContainerView * containerView;
@property(nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) HYUkHomeSearchView *searchView;
@property (nonatomic, strong) QMUIButton *messageBtn;

@end

@implementation HYUkHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.clearColor;
    self.bgImageView.image = [UIImage uk_bundleImage:@"WechatIMG488"];
    
    [self.navBar addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navBar.mas_left).offset(16);
        make.right.equalTo(self.navBar.mas_right).offset(-52);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.navBar addSubview:self.messageBtn];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navBar.mas_right).offset(-6);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.width.height.mas_equalTo(40);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.messageBtn blockEvent:^(UIButton *button) {

    }];
    
    _titleArray = @[@"推荐",@"电影",@"电视剧",@"动漫",@"综艺",@"纪录片"];

    _headerView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = UIColor.clearColor;
    _headerView.titles = _titleArray;
    _headerView.titleColor = UIColor.textColor22;
    _headerView.titleSelectedColor = UIColor.whiteColor;
    _headerView.titleSelectedFont = [UIFont boldSystemFontOfSize:16];
    _headerView.titleFont = UIFontMake(14);
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
        make.top.equalTo(self.navBar.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(IS_iPhoneX ? 80 : 50));
    }];
}

#pragma mark-- <JXCategoryListContainerViewDelegate>
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        HYUkRecommendVC * listVC = [[HYUkRecommendVC alloc] init];
        return listVC;
    }
    HYUkOtherViewController * listVC = [[HYUkOtherViewController alloc] init];
    listVC.index = index;
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

- (void)customView:(HYBaseView *)view event:(id)event{
    if ([view isKindOfClass:[HYUkHomeSearchView class]]) {
        HYUkSearchViewController *vc = [HYUkSearchViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (QMUIButton *)messageBtn {
    if (!_messageBtn) {
        _messageBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setImage:[UIImage uk_bundleImage:@"xiaoxi"] forState:0];
        _messageBtn.qmui_badgeLabel.text = @"10";
        _messageBtn.qmui_badgeTextColor = UIColor.redColor;
    }
    return _messageBtn;
}

@end
