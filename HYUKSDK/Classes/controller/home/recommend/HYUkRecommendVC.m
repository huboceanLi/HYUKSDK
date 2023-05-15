//
//  HYUkRecommendVC.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/6.
//

#import "HYUkRecommendVC.h"
#import "HYUkHomeRecommendCell.h"
#import "HYUkRecommendHeadView.h"
#import "HYResponseRecommendModel.h"
#import "HYUkDetailViewController.h"

@interface HYUkRecommendVC ()<UITableViewDelegate,UITableViewDataSource, BaseCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dataDic;

@end

@implementation HYUkRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 15, 0)];
    [ _tableView registerClass:[HYUkHomeRecommendCell class] forCellReuseIdentifier:@"Cell"];
    [_tableView updateEmptyViewWithImageName:@"uk_nodata" title:@"暂无数据"];

//    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeInfoCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    if (@available (iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);

//        make.bottom.equalTo(self.view.mas_bottom).offset(-(IS_iPhoneX ? 88 : 64));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getData];
    });
}

- (void)getData {
    
    [[HYUkShowLoadingManager sharedInstance] showLoading:-1];

    __weak typeof(self) weakSelf = self;
    [[HYVideoSingle sharedInstance] homeRecommendWithListSuccess:^(NSString *message, id responseObject) {
        NSArray *models = responseObject;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (HYResponseRecommendModel * item in models) {
            
            NSString *tid = [NSString stringWithFormat:@"%ld",item.type_id_1];
            
            if ([dic.allKeys containsObject:tid]) {
                NSMutableArray *itemArr = [NSMutableArray array];
                itemArr = [dic[tid] mutableCopy];
                [itemArr addObject:item];
                [dic setObject:itemArr forKey:tid];
            }else {
                [dic setObject:@[item] forKey:tid];
            }
        }
        weakSelf.dataDic = [dic mutableCopy];
        [weakSelf.tableView reloadData];
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        if (errorType == CTAPIManagerErrorTypeNoNetWork) {
            [weakSelf.tableView updateEmptyViewWithImageName:@"uk_net_err" title:errorMessage];
        }else {
            [weakSelf.tableView updateEmptyViewWithImageName:@"uk_load_err" title:@"加载失败!"];
        }
        [weakSelf.tableView reloadData];
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
    }];
}

#pragma mark - Table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataDic.allKeys.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat leftSpace = 15;
    CGFloat space = 8;
    NSInteger count = 3;
    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
    CGFloat h = 160 * w / 120 + 6 + 20;
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 46.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    HYUkRecommendHeadView *lineView = [[HYUkRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 46.f)];
//    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    if (section == 0) {
        lineView.name.text = @"电影";
    }
    if (section == 1) {
        lineView.name.text = @"电视剧";
    }
    if (section == 2) {
        lineView.name.text = @"综艺";
    }
    if (section == 3) {
        lineView.name.text = @"动漫";
    }
    if (section == 4) {
        lineView.name.text = @"记录片";
    }
    return lineView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr;
    if (section == 0) {
        arr = self.dataDic[@"1"];
    }
    if (section == 1) {
        arr = self.dataDic[@"2"];
    }
    
    if (section == 2) {
        arr = self.dataDic[@"3"];
    }
    
    if (section == 3) {
        arr = self.dataDic[@"4"];
    }
    if (section == 4) {
        arr = self.dataDic[@"24"];
    }
    if (arr.count > 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYUkHomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HYUkHomeRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = 0;
    cell.delegate = self;
    NSArray *arr;
    if (indexPath.section == 0) {
        arr = self.dataDic[@"1"];
    }
    if (indexPath.section == 1) {
        arr = self.dataDic[@"2"];
    }
    
    if (indexPath.section == 2) {
        arr = self.dataDic[@"3"];
    }
    
    if (indexPath.section == 3) {
        arr = self.dataDic[@"4"];
    }
    if (indexPath.section == 4) {
        arr = self.dataDic[@"24"];
    }
    cell.data = arr;
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)customCell:(HYBaseTableViewCell *)cell event:(id)event
{
    BOOL isOpenTheProxy = [[HYUkConfigManager sharedInstance] isOpenTheProxy];
    if (isOpenTheProxy) {
        [MYToast showWithText:@"请关闭设备代理,否则会播放失败!"];
        return;
    }
    HYResponseRecommendModel *model = event;
    HYUkDetailViewController *vc = [HYUkDetailViewController new];
    vc.videoId = model.video_id;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
