//
//  HYUkDownViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import "HYUkDownViewController.h"
#import "HYUkDownContentVC.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkDownViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property(nonatomic, strong) JXCategoryTitleView * headerView;
@property(nonatomic, strong) JXCategoryListContainerView * containerView;
@property(nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) UIButton *clearBtn;
@property(nonatomic, assign) NSInteger recordIndex;
@property (nonatomic, strong) NSMutableDictionary *vcDic;

@end

@implementation HYUkDownViewController

- (void)dealloc {
    NSLog(@"HYUkDownViewController 灰飞烟灭");
}

- (UIButton *)clearBtn {
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setTitle:@"管理" forState:0];
        [_clearBtn setTitleColor:UIColor.textColor22 forState:0];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _clearBtn.adjustsImageWhenHighlighted = NO;
    }
    return _clearBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.whiteColor;
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    self.navTitleLabel.text = @"我的下载";
    self.navTitleLabel.textColor = UIColor.textColor22;
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"31fanhui1"] forState:0];
    
    self.vcDic = [NSMutableDictionary dictionary];
    
    [self.navBar addSubview:self.clearBtn];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navBar.mas_right).offset(-10);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.clearBtn blockEvent:^(UIButton *button) {
        NSString *s = [NSString stringWithFormat:@"%ld",self.recordIndex];
        HYUkDownContentVC *vc = self.vcDic[s];
        [vc deleteData];
//        if (self.recordIndex == 1) {
//            [vc deleteData];
//            [[HYUkDownListLogic share] deleteAllWithStatus:1];
//            [weakSelf.containerView reloadData];
//        }
    }];
    
    _titleArray = @[@"下载中",@"已下载"];

    _headerView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = UIColor.clearColor;
    _headerView.titles = _titleArray;
    _headerView.titleColor = UIColor.textColor22;
    _headerView.titleSelectedColor = UIColor.mainColor;
    _headerView.titleSelectedFont = [UIFont boldSystemFontOfSize:16];
    _headerView.titleFont = UIFontMake(14);
    _headerView.titleColorGradientEnabled = YES;
    _headerView.titleLabelZoomScale = 1.1;
    _headerView.titleLabelZoomEnabled = YES;
    _headerView.cellWidth = ceil(SCREEN_WIDTH / 2);
    _headerView.cellSpacing = 0;
//    _headerView.qmui_borderPosition = QMUIViewBorderPositionBottom;
    _headerView.delegate = self;
    [self.view addSubview:_headerView];
    
    JXCategoryIndicatorLineView * lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = 30;
    lineView.verticalMargin = 4;
    lineView.indicatorColor = [UIColor mainColor];
    self.headerView.indicators = @[lineView];
    
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
        make.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark-- <JXCategoryListContainerViewDelegate>
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {

    HYUkDownContentVC * listVC = [[HYUkDownContentVC alloc] init];
    listVC.index = index;
    
    [self.vcDic setObject:listVC forKey:[NSString stringWithFormat:@"%ld",index]];
    
    return listVC;

}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return _titleArray.count;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    self.recordIndex = index;
}

@end
