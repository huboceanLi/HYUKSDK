//
//  HYUkCenterViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkCenterViewController.h"
#import "HYUkLoginView.h"
#import "HYUkCenterHistoryView.h"
#import "HYCenterToolView.h"
#import "HYUkCollectionViewController.h"
#import "HYUkDownViewController.h"
#import "HYUkSettingViewController.h"
#import "HYUkCenterHistoryListViewController.h"
#import "HYUKSDK/HYUKSDK-Swift.h"
#import "HYUkDetailViewController.h"

@interface HYUkCenterViewController ()<HYBaseViewDelegate>

@property(nonatomic, strong) UIScrollView * scrollView;
@property(nonatomic, strong) HYUkLoginView * loginView;
@property(nonatomic, strong) HYUkCenterHistoryView * historyView;
@property(nonatomic, strong) HYCenterToolView * toolView;

@end

@implementation HYUkCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.clearColor;
    self.bgImageView.image = [UIImage uk_bundleImage:@"WechatIMG488"];

    self.scrollView = [UIScrollView new];
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
//    [self.scrollView setContentInset:UIEdgeInsetsMake((IS_iPhoneX ? 88 : 64), 0, 0, 0)];
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0, *)) {
        [self.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(IS_iPhoneX ? 80 : 50));
//        make.top.equalTo(self.navBar.mas_bottom).offset(0);
    }];

    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - (IS_iPhoneX ? 79 : 49))];
    
    self.loginView = [HYUkLoginView new];
    self.loginView.delegate = self;
    [self.scrollView addSubview:self.loginView];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top).offset(IS_iPhoneX ? 88 : 64);
        make.left.equalTo(self.scrollView.mas_left).offset(15);
        make.width.mas_offset(SCREEN_WIDTH - 30);
        make.height.mas_offset(100);
    }];
    
    self.toolView = [HYCenterToolView new];
    self.toolView.delegate = self;
    [self.scrollView addSubview:self.toolView];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginView.mas_bottom).offset(20);
        make.left.equalTo(self.scrollView.mas_left).offset(15);
        make.width.mas_offset(SCREEN_WIDTH - 30);
        make.height.mas_offset(115);
    }];
    
    self.historyView = [HYUkCenterHistoryView new];
    self.historyView.delegate = self;
    [self.scrollView addSubview:self.historyView];
    
    [self.historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolView.mas_bottom).offset(20);
        make.left.equalTo(self.scrollView.mas_left).offset(15);
        make.width.mas_offset(SCREEN_WIDTH - 30);
        make.height.mas_offset(152);
    }];
}

- (void)getData {
    NSArray *arr = [[HYUkHistoryRecordLogic share] queryHistoryRecordListWithCreateTime:NSIntegerMax count:7];
    self.historyView.data = arr;
    [self.historyView loadContent];
}

- (void)customView:(HYBaseView *)view event:(id)event {
    if ([view isKindOfClass:[HYCenterToolView class]]) {
        NSInteger index = [event intValue];
        if (index == 1) {
            HYUkCollectionViewController *vc = [HYUkCollectionViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 2) {
            HYUkDownViewController *vc = [HYUkDownViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 3) {
            
        }else if (index == 4) {
            HYUkSettingViewController *vc = [HYUkSettingViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        return;
    }
    
    if ([view isKindOfClass:[HYUkCenterHistoryView class]]) {
        NSDictionary *dic = event;
        if ([dic[@"type"] isEqualToString:@"more"]) {
            HYUkCenterHistoryListViewController *vc = [HYUkCenterHistoryListViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            BOOL isOpenTheProxy = [[HYUkConfigManager sharedInstance] isOpenTheProxy];
            if (isOpenTheProxy) {
                [MYToast showWithText:@"请关闭设备代理,否则会播放失败!"];
                return;
            }
            HYUkDetailViewController *vc = [HYUkDetailViewController new];
            vc.videoId = [dic[@"tvId"]  integerValue];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
}

@end
