//
//  HYUkSearchViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkSearchViewController.h"
#import "HYUkSearchHeadView.h"
#import "HYUkSearchListView.h"
#import "HYUkHistoryView.h"
#import "HYUkHeader.h"
#import "HYUkDetailViewController.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkSearchViewController ()<HYBaseViewDelegate>

@property (nonatomic, strong) HYUkSearchHeadView *searchHeadView;
@property (nonatomic, strong) HYUkSearchListView *searchListView;
@property (nonatomic, strong) HYUkHistoryView *historyView;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *keyWords;

@end

@implementation HYUkSearchViewController

- (void)dealloc {
    NSLog(@"HYUkSearchViewController dealloc");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.searchHeadView.textField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.clearColor;
//    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
//    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"uk_back"] forState:0];
    
    [self.navBar addSubview:self.searchHeadView];
    [self.searchHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navBackButton.mas_right).offset(0);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.right.equalTo(self.navBar.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.historyView];
    
    [self.historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.view addSubview:self.searchListView];
    
    [self.searchListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.searchListView.hidden = YES;
}

- (HYUkSearchHeadView *)searchHeadView {
    if (!_searchHeadView) {
        _searchHeadView = [HYUkSearchHeadView new];
        _searchHeadView.delegate = self;
    }
    return _searchHeadView;
}

- (HYUkSearchListView *)searchListView {
    if (!_searchListView) {
        _searchListView = [HYUkSearchListView new];
        _searchListView.delegate = self;
    }
    return _searchListView;
}

- (HYUkHistoryView *)historyView {
    if (!_historyView) {
        _historyView = [HYUkHistoryView new];
        _historyView.delegate = self;
    }
    return _historyView;
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    if ([view isKindOfClass:[HYUkSearchHeadView class]]) {
        NSDictionary *dic = event;
        
        if ([self.searchHeadView.searchBtn.titleLabel.text isEqualToString:@"取消"]) {
            if (!self.historyView.hidden) {
                [self.view endEditing:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                self.historyView.hidden = NO;
                self.searchListView.hidden = YES;
                [self.historyView loadContent];
            }
        }else {
            NSString *k = dic[@"key"];
            if (k.length != 0) {
                if (![self.keyWords isEqualToString:dic[@"key"]]) {
                    self.keyWords = dic[@"key"];
                    self.page = 0;
                    [self searchApi];
                }
            }
        }
        return;
    }
    
    if ([view isKindOfClass:[HYUkHistoryView class]]) {
        [self.view endEditing:YES];
        self.historyView.hidden = YES;
        self.searchListView.hidden = NO;
        HYUkTextTempModel *m = (HYUkTextTempModel *)event;
        self.page = 0;
        self.keyWords = m.name;
        self.searchHeadView.textField.text = self.keyWords;
        [self searchApi];
    }
    
    if ([view isKindOfClass:[HYUkSearchListView class]]) {
        [self.view endEditing:YES];
        
        NSDictionary *dic = (NSDictionary *)event;
        if ([dic[@"type"] isEqualToString:@"more"]) {
            self.page++;
            [self searchApi];
        }else {
            BOOL isOpenTheProxy = [[HYUkVideoConfigManager sharedInstance] isOpenTheProxy];
            if (isOpenTheProxy) {
                [MYToast showWithText:@"请关闭设备代理,否则会播放失败!"];
                return;
            }
            HYUkDetailViewController *vc = [HYUkDetailViewController new];
            vc.videoId = [dic[@"ID"] intValue];
            [self.navigationController pushViewController:vc animated:YES];
        }

//        NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
//        
//        for (UIViewController *item in vcs) {
//            if ([item isKindOfClass:[HYUkSearchViewController class]]) {
//                [vcs removeObject:item];
//                self.navigationController.viewControllers = vcs;
//                break;
//            }
//        }
    }
}

- (void)searchApi {
    __weak typeof(self) weakSelf = self;
    if (self.page == 0) {
        [[HYUkShowLoadingManager sharedInstance] showLoading:-1];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HYVideoSingle sharedInstance] getSearchListWithKeywords:self.keyWords page:self.page success:^(NSString *message, id responseObject) {
            weakSelf.historyView.hidden = YES;
            weakSelf.searchListView.hidden = NO;
            NSArray *arr = responseObject;
            if (arr.count > 0) {
                [[HYVideoSearchLogic share] insertMovieListWithName:self.keyWords];
            }
            weakSelf.searchListView.data = responseObject;
            [weakSelf.searchListView loadContent];
            [[HYUkShowLoadingManager sharedInstance] removeLoading];
            [weakSelf.searchListView.tableView.mj_footer endRefreshing];
        } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
            [weakSelf.searchListView.tableView.mj_footer endRefreshing];
            if (errorType == CTAPIManagerErrorTypeNoNetWork) {
                [weakSelf.searchListView.tableView updateEmptyViewWithImageName:@"uk_net_err" title:errorMessage];
            }else {
                [weakSelf.searchListView.tableView updateEmptyViewWithImageName:@"uk_load_err" title:@"加载失败!"];
            }
            [weakSelf.searchListView.tableView reloadData];
            [[HYUkShowLoadingManager sharedInstance] removeLoading];
        }];
    });
}

@end
