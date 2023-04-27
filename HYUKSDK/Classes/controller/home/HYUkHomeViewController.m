//
//  HYUkHomeViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkHomeViewController.h"
#import "HYUkOtherViewController.h"
#import "HYUkRecommendVC.h"

@interface HYUkHomeViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property(nonatomic, strong) JXCategoryTitleView * headerView;
@property(nonatomic, strong) JXCategoryListContainerView * containerView;
@property(nonatomic, strong) NSArray * titleArray;

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
    self.navBar.backgroundColor = UIColor.mainColor;
    
    _titleArray = @[@"推荐",@"电影",@"电视剧",@"动漫",@"综艺",@"纪录片"];

    _headerView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = UIColor.whiteColor;
    _headerView.titles = _titleArray;
    _headerView.titleColor = UIColor.textColor99;
    _headerView.titleSelectedColor = UIColor.mainColor;
    _headerView.titleSelectedFont = UIFontMediumMake(14);
    _headerView.titleFont = UIFontMake(14);
    _headerView.titleColorGradientEnabled = YES;
    _headerView.titleLabelZoomScale = 1;
    _headerView.titleLabelZoomEnabled = YES;
    _headerView.cellWidth = 60;
    _headerView.cellSpacing = 12;
    _headerView.qmui_borderPosition = QMUIViewBorderPositionBottom;
    _headerView.delegate = self;
    [self.view addSubview:_headerView];

    _containerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
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

@end
