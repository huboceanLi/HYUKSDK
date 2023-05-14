//
//  HYUkCenterHistoryListViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import "HYUkCenterHistoryListViewController.h"
#import "HYUkCenterHistoryListCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"
#import "HYUkDetailViewController.h"

@interface HYUkCenterHistoryListViewController ()<UITableViewDelegate,UITableViewDataSource,HYUkDetailViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger create_Time;


@end

@implementation HYUkCenterHistoryListViewController

- (UIButton *)clearBtn {
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setImage:[UIImage uk_bundleImage:@"qingchu_1"] forState:0];
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
    self.navTitleLabel.text = @"观看历史";
    self.navTitleLabel.textColor = UIColor.textColor22;
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"31fanhui1"] forState:0];
    
    self.create_Time = NSIntegerMax;
    self.dataArray = [NSMutableArray array];
    
    [self.navBar addSubview:self.clearBtn];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navBar.mas_right).offset(-10);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.clearBtn blockEvent:^(UIButton *button) {
        [[HYUkHistoryRecordLogic share] clearData];
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.tableView reloadData];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, (IS_iPhoneX ? 44 : 10), 0)];
    [ _tableView registerClass:[HYUkCenterHistoryListCell class] forCellReuseIdentifier:@"Cell"];

//    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeInfoCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    if (@available (iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getData];
    });
}

- (void)getData {
    NSArray *arr = [[HYUkHistoryRecordLogic share] queryHistoryRecordListWithCreateTime:self.create_Time count:20];
    [self.dataArray addObjectsFromArray:arr];
    [self.tableView reloadData];
}

#pragma mark - Table view datasource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *arr = self.list[section];
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYUkCenterHistoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HYUkCenterHistoryListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = 0;
    cell.data = self.dataArray[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    BOOL isOpenTheProxy = [[HYUkConfigManager sharedInstance] isOpenTheProxy];
    if (isOpenTheProxy) {
        [MYToast showWithText:@"请关闭设备代理,否则会播放失败!"];
        return;
    }
    
    HYUkHistoryRecordModel *recordModel = self.dataArray[indexPath.row];

    HYUkDetailViewController *vc = [HYUkDetailViewController new];
    vc.videoId = recordModel.tvId;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)changeVideoProgressVideoId:(NSInteger)videoId
{
    HYUkHistoryRecordModel *tempModel = [[HYUkHistoryRecordLogic share] queryAppointRecordWithVideoId:videoId];
    
    if (tempModel) {
        for (HYUkHistoryRecordModel *item in self.dataArray) {
            if (item.tvId == tempModel.tvId) {
                [self.dataArray removeObject:item];
                [self.dataArray insertObject:tempModel atIndex:0];
                [self.tableView reloadData];
                break;
            }
        }
    }
}

@end
