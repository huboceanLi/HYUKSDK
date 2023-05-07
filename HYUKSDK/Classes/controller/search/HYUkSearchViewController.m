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
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"31fanhui1"] forState:0];
    
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
        if ([dic[@"isBack"] integerValue] == 1) {
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([dic[@"isBack"] integerValue] == 2) {
            self.historyView.hidden = NO;
            self.searchListView.hidden = YES;
        }else {
            if (![self.keyWords isEqualToString:dic[@"key"]]) {
                self.keyWords = dic[@"key"];
                self.page = 0;
                [self searchApi];
                NSLog(@"开始搜索了");
            }

//            NSString *url = [NSString stringWithFormat:@"%@?search_text=%@&cat=1002",API_DouBan_Search_List,dic[@"key"]];
//            NSString *encodedString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            [self.tempWebView getVideoUrl:encodedString];
        }
        return;
    }
    
    if ([view isKindOfClass:[HYUkHistoryView class]]) {
        [self.view endEditing:YES];
        self.historyView.hidden = YES;
        self.searchListView.hidden = NO;

    }
    
    if ([view isKindOfClass:[HYUkSearchListView class]]) {
        [self.view endEditing:YES];
        HYUkDetailViewController *vc = [HYUkDetailViewController new];
        vc.videoId = [event intValue];
        [self.navigationController pushViewController:vc animated:YES];
        
        NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
        
        for (UIViewController *item in vcs) {
            if ([item isKindOfClass:[HYUkSearchViewController class]]) {
                [vcs removeObject:item];
                self.navigationController.viewControllers = vcs;
                break;
            }
        }
    }
}

- (void)searchApi {
    __weak typeof(self) weakSelf = self;
    [[HYUkShowLoadingManager sharedInstance] showLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HYVideoSingle sharedInstance] getSearchListWithKeywords:self.keyWords page:self.page success:^(NSString *message, id responseObject) {
            weakSelf.historyView.hidden = YES;
            weakSelf.searchListView.hidden = NO;
            weakSelf.searchListView.data = responseObject;
            [weakSelf.searchListView loadContent];
            [[HYUkShowLoadingManager sharedInstance] removeLoading];
        } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
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
