//
//  HYUkCollectionViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import "HYUkCollectionViewController.h"
#import "HYUkCollectionCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"
#import "HYUkDetailViewController.h"

@interface HYUkCollectionViewController ()<UITableViewDelegate,UITableViewDataSource,HYUkDetailViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger create_Time;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *clearBtn;

@end

@implementation HYUkCollectionViewController

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
    self.create_Time = NSIntegerMax;
    self.dataArray = [NSMutableArray array];
    
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    self.navTitleLabel.text = @"我的收藏";
    self.navTitleLabel.textColor = UIColor.textColor22;
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"31fanhui1"] forState:0];
    
    [self.navBar addSubview:self.clearBtn];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navBar.mas_right).offset(-10);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.clearBtn blockEvent:^(UIButton *button) {
        [[HYVideoCollectionLogic share] clearData];
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
    [ _tableView registerClass:[HYUkCollectionCell class] forCellReuseIdentifier:@"Cell"];
    [_tableView updateEmptyViewWithImageName:@"uk_nodata" title:@"暂无数据"];

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
    NSArray *arr = [[HYVideoCollectionLogic share] queryCollectionListWithCreateTime:self.create_Time];
    if (arr.count > 0) {
        HYUkCollectionModel *lastModel = arr.firstObject;
        self.create_Time = lastModel.create_Time;
        [self.dataArray addObjectsFromArray:arr];
        [self.tableView reloadData];
    }else {
        [self.tableView reloadData];
    }
}

#pragma mark - Table view datasource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat w = 70;
    CGFloat h = 160 * w / 120 + 20;
    return h;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYUkCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HYUkCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = 0;
    cell.data = self.dataArray[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    HYUkCollectionModel *model = self.dataArray[indexPath.row];
    HYUkDetailViewController *vc = [HYUkDetailViewController new];
    vc.videoId = model.video_id;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)changeLikeStatus:(BOOL)isLike videoId:(NSInteger)videoId
{
    if (isLike) {
        HYUkCollectionModel *model = [[HYVideoCollectionLogic share] queryAppointCollectionWithVideoId:videoId];
        if (model != nil) {
            [self.dataArray insertObject:model atIndex:0];
            [self.tableView reloadData];
        }
    }else {
        for (HYUkCollectionModel *item in self.dataArray) {
            if (item.video_id == videoId) {
                [self.dataArray removeObject:item];
                [self.tableView reloadData];
                break;
            }
        }
    }
}

@end
