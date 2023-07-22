//
//  HYUkDownVC.m
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/16.
//

#import "HYUkDownVC.h"
#import "HYUkDownCompleteCell.h"
#import "HYUkDownProgressCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"
#import "HYUkPlayDownViewController.h"
#import "SJMediaCacheServer.h"
#import "HYUkDownEditView.h"

@interface HYUkDownVC ()<UITableViewDelegate,UITableViewDataSource,BaseCellDelegate,HYUkDownManagerDelegate,HYBaseViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HYUkDownEditView *editView;

@end

@implementation HYUkDownVC

- (void)dealloc {
    [HYUkDownManager sharedInstance].delegate = nil;
    NSLog(@"HYUkDownVC 灰飞烟灭");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.whiteColor;
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    self.navTitleLabel.text = @"我的下载";
    self.navTitleLabel.textColor = UIColor.textColor22;
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"uk_back"] forState:0];
    
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
    self.editView.delegate = self;
    [self.view addSubview:self.editView];
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(IS_iPhoneX ? 90 : 46);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.editView.mas_bottom).offset(0);
    }];
    [HYUkDownManager sharedInstance].delegate = self;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getData];
    });
}

- (void)getData {
    self.dataArray = [[[HYUkDownListLogic share] queryDownAllList] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Table view datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return XJFlexibleFont(90);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - UITableViewDelegate -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HYUkDownListModel *model = self.dataArray[indexPath.row];

    if (model.status == 0) {
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
    if (model.status == 0) {
        [[HYUkDownManager sharedInstance] startDown:model];
        
    }else {
        HYUkPlayDownViewController *vc = [HYUkPlayDownViewController new];
        vc.downModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYUkDownListModel *model = self.dataArray[indexPath.row];

    NSLog(@"commitEditingStyle");
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (model.status == 0) {
        [[HYUkDownManager sharedInstance] endDown:model];
    }
    [[HYUkDownManager sharedInstance] removeCacheForURLs:@[model.playUrl]];
    [self.dataArray removeObject:model];
    [[HYUkDownListLogic share] removeAppointDownWithPrimaryId:model.primary_Id];
    [self.tableView endUpdates];
}



- (void)customCell:(HYBaseTableViewCell *)cell event:(id)event
{
    if ([cell isKindOfClass:[HYUkDownProgressCell class]]) {
        NSString *primary_Id = event;
        
        for (int i = 0; i < self.dataArray.count; i++) {
            HYUkDownListModel *model = self.dataArray[i];
            if ([model.primary_Id isEqualToString:primary_Id]) {
                model.status = 1;
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
                break;
            }
        }

    }
}

- (void)downProgress:(NSString *)primary_Id progress:(NSInteger)progress status:(HYUkDownStatus)status
{
    for (int i = 0; i < self.dataArray.count; i++) {
        HYUkDownListModel *model = self.dataArray[i];
        if ([model.primary_Id isEqualToString:primary_Id] && model.status == 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            HYUkDownProgressCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell downProgress:primary_Id progress:progress status:status];
            break;
        }
    }
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    NSInteger index = [event integerValue];
    if (index == 1) { //all down
        for (HYUkDownListModel *item in self.dataArray) {
            [[HYUkDownManager sharedInstance] startDown:item];
        }
        return;
    }
    
    if (index == 2) { //all delete
        [[SJMediaCacheServer shared] cancelAllPrefetchTasks];
        NSMutableArray *arr = [NSMutableArray array];
        for (HYUkDownListModel *item in self.dataArray) {
            [arr addObject:item.playUrl];
        }
        [[HYUkDownManager sharedInstance] removeCacheForURLs:arr];
        [[HYUkDownListLogic share] clearData];
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        return;
    }
}

@end
