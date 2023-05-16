//
//  HYUkDownContentVC.m
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/14.
//

#import "HYUkDownContentVC.h"
#import "HYUkDownCompleteCell.h"
#import "HYUkDownProgressCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"
#import "HYUkPlayDownViewController.h"
#import "SJMediaCacheServer.h"
#import "HYUkDownEditView.h"

@interface HYUkDownContentVC ()<UITableViewDelegate,UITableViewDataSource,BaseCellDelegate,HYUkDownManagerDelegate,HYBaseViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HYUkDownEditView *editView;

@end

@implementation HYUkDownContentVC

- (void)dealloc {
    NSLog(@"HYUkDownContentVC 灰飞烟灭");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, (IS_iPhoneX ? 44 : 10), 0)];
    [ _tableView registerClass:[HYUkDownCompleteCell class] forCellReuseIdentifier:@"CompleteCell"];
    [ _tableView registerClass:[HYUkDownProgressCell class] forCellReuseIdentifier:@"ProgressCell"];
    [self.tableView updateEmptyViewWithImageName:@"uk_nodata" title:@"暂无数据"];

//    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeInfoCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    if (@available (iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }

    
    self.editView = [HYUkDownEditView new];
    [self.view addSubview:self.editView];
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(IS_iPhoneX ? 90 : 46);
        make.bottom.equalTo(self.view).offset(IS_iPhoneX ? 90 : 46);
    }];
    self.editView.hidden = YES;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
        make.bottom.equalTo(self.editView.mas_bottom).offset(0);
    }];
    
    if (self.index == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getData];
        });
    }
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.index == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getData];
        });
    }
}

- (void)getData {
    if (self.index == 0) {
        [HYUkDownManager sharedInstance].delegate = self;

        self.dataArray = [[[HYUkDownListLogic share] queryDownListWithCreateTime:NSIntegerMax isComplete:YES] mutableCopy];
    }else {
        self.dataArray = [[[HYUkDownListLogic share] queryDownListWithCreateTime:NSIntegerMax isComplete:NO] mutableCopy];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - UITableViewDelegate -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.index == 0) {
        HYUkDownProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgressCell"];
        if (!cell) {
            cell = [[HYUkDownProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProgressCell"];
        }
        cell.selectionStyle = 0;
        cell.delegate = self;
        cell.data = self.dataArray[indexPath.row];
        [cell loadContent];
        
        return cell;
    }
    
    HYUkDownCompleteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompleteCell"];
    if (!cell) {
        cell = [[HYUkDownCompleteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompleteCell"];
    }
    cell.selectionStyle = 0;
    cell.data = self.dataArray[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HYUkDownListModel *model = self.dataArray[indexPath.row];
    if (self.index == 0) {
        [[HYUkDownManager sharedInstance] startDown:model];
    }else {
        HYUkPlayDownViewController *vc = [HYUkPlayDownViewController new];
        vc.downModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)customCell:(HYBaseTableViewCell *)cell event:(id)event
{
    if ([cell isKindOfClass:[HYUkDownProgressCell class]]) {
        NSString *primary_Id = event;
        for (HYUkDownListModel *model in self.dataArray) {
            if ([model.primary_Id isEqualToString:primary_Id]) {
                [self.dataArray removeObject:model];
                [self.tableView reloadData];
                break;
            }
        }
    }
}

- (void)downProgress:(NSString *)primary_Id progress:(NSInteger)progress status:(HYUkDownStatus)status
{
    for (int i = 0; i < self.dataArray.count; i++) {
        HYUkDownListModel *model = self.dataArray[i];
        if ([model.primary_Id isEqualToString:primary_Id]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            HYUkDownProgressCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell downProgress:primary_Id progress:progress status:status];
            break;
        }
    }
}

- (void)deleteData
{
    if (self.index == 1) {
        [self.editView changeUI:false];

//        [[HYUkDownListLogic share] deleteAllWithStatus:1];
    }else {
        [self.editView changeUI:true];

//        [[SJMediaCacheServer shared] cancelAllPrefetchTasks];
//        [[HYUkDownListLogic share] deleteAllWithStatus:0];
    }
    self.editView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self.editView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(0);
        }];
        [self.editView.superview layoutIfNeeded];
    }];
//    NSMutableArray *arr = [NSMutableArray array];
//    for (HYUkDownListModel *item in self.dataArray) {
//        [arr addObject:item.playUrl];
//    }
//    [[HYUkDownManager sharedInstance] removeCacheForURLs:arr];
//    [self.dataArray removeAllObjects];
//    [self.tableView reloadData];
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    
}

@end
