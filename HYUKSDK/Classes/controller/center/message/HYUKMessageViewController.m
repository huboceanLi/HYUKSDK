//
//  HYUKMessageViewController.m
//  AFNetworking
//
//  Created by Ocean 李 on 2023/6/15.
//

#import "HYUKMessageViewController.h"
#import "HYUkRequestWorking.h"
#import "HYUKNoticeTableViewCell.h"
#import "HYUKMessageDetailVC.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUKMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIButton *clearBtn;

@end

@implementation HYUKMessageViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSInteger count = [[HYUKNoticeListLogic share] getUnReadCount];
    if (count == 0) {
        self.clearBtn.hidden = YES;
    }else {
        self.clearBtn.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.whiteColor;
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#F5F5F5"];
    
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    self.navTitleLabel.text = @"消息中心";
    self.navTitleLabel.textColor = UIColor.textColor22;
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"uk_back"] forState:0];
    
    [self.navBar addSubview:self.clearBtn];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navBar.mas_right).offset(-12);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(-4);
        make.height.mas_equalTo(40);
    }];


    __weak typeof(self) weakSelf = self;
    [self.clearBtn blockEvent:^(UIButton *button) {
        [MBProgressHUD showActivityMessageInWindow:@"" timer:10];
        [[HYUKNoticeListLogic share] markAllIsReadWithComplete:^{
            weakSelf.clearBtn.hidden = YES;
            [MBProgressHUD hideHUD];
            [[NSNotificationCenter defaultCenter] postNotificationName:notice_isRead object:nil];
        }];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 15, 0)];
    [ _tableView registerClass:[HYUKNoticeTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [_tableView updateEmptyViewWithImageName:@"uk_nodata" title:@"暂无数据"];

//    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeInfoCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    if (@available (iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-(IS_iPhoneX ? 88 : 64));
    }];
    
    
    self.dataArray = [[HYUKNoticeListLogic share] queryNoticeList];
    [self.tableView reloadData];
//    [HYUkRequestWorking getNoticeWithListSuccess:^(NSArray<HYUKResponseNoticeItemModel *> * _Nonnull models, BOOL success) {
//        if (success) {
//            weakSelf.dataArray = models;
//        }
//
//    }];
}

#pragma mark - Table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return XJFlexibleFont(16);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYUKNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HYUKNoticeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = 0;

    cell.data = self.dataArray[indexPath.section];
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    HYUKMessageDetailVC *vc = [HYUKMessageDetailVC new];
    vc.noticeItemModel = self.dataArray[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIButton *)clearBtn {
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setTitle:@"全部已读" forState:0];
        [_clearBtn setTitleColor:UIColor.mainColor forState:0];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _clearBtn.adjustsImageWhenHighlighted = NO;
    }
    return _clearBtn;
}

@end
