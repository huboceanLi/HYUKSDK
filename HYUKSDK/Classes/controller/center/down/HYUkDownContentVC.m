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


#import "SJMediaCacheServer.h"

@interface HYUkDownContentVC ()<UITableViewDelegate,UITableViewDataSource,BaseCellDelegate,HYUkDownManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getData];
    });
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
    
    if (self.index == 0) {
        HYUkDownListModel *model = self.dataArray[indexPath.row];

        [[HYUkDownManager sharedInstance] startDown:model];
        
//        if ([[HYUkDownManager sharedInstance].downIngArray containsObject:model.primary_Id]) {
//            //暂停
//            [[SJMediaCacheServer shared] cancelAllPrefetchTasks];
//            return;
//        }
//
//        if ([[HYUkDownManager sharedInstance].downWaitArray containsObject:model.primary_Id]) {
//            //暂停
//            [[SJMediaCacheServer shared] cancelAllPrefetchTasks];
//            return;
//        }
        
//        if ([[HYUkDownManager sharedInstance].downPauseArray containsObject:model.primary_Id]) {
//            //排队或者开始下载
//            return;
//        }
        //三个数组都没有就开启下载
//        [[HYUkDownManager sharedInstance].downIngArray addObject:model.primary_Id];
//        __weak typeof(self) weakSelf = self;
//        [[SJMediaCacheServer shared] prefetchWithURL:[NSURL URLWithString:model.playUrl] progress:^(float progress) {
//            NSLog(@"下载进度:%.2f",progress);
//        } completed:^(NSError * _Nullable error) {
//            if (!error) {
////                [[HYUkDownManager sharedInstance].downIngArray removeObject:model.primary_Id];
//                [weakSelf.dataArray removeObject:model];
//                [weakSelf.tableView reloadData];
//                NSLog(@"下载完成");
//            }else {
//                NSLog(@"下载出错了:%@",error);
//            }
//        }];
//        [[MCSPrefetcherManager shared] prefetchWithURL:[NSURL URLWithString:model.playUrl] preloadSize:2000 * 1024 * 1024 progress:^(float progress) {
//        } completed:^(NSError * _Nullable error) {
//        }];
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

@end
