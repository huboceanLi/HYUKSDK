//
//  HYUkRankViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkRankViewController.h"
#import "HYUkRankViewCell.h"
#import "HYUkDetailViewController.h"

@interface HYUkRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HYUkRankViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.bgColor;
    self.navBar.backgroundColor = UIColor.clearColor;
    self.bgImageView.image = [UIImage uk_bundleImage:@"uk_bg_Img"];
    self.navTitleLabel.text = @"排行榜";
    
    self.dataArray = [NSMutableArray array];
    [self getData];
}

- (void)initSubviews {
    [super initSubviews];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 15, 0)];
    [ _tableView registerClass:[HYUkRankViewCell class] forCellReuseIdentifier:@"Cell"];
    [_tableView updateEmptyViewWithImageName:@"uk_nodata" title:@"暂无数据"];

//    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeInfoCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    if (@available (iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(IS_iPhoneX ? 80 : 50));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)getData {
    __weak typeof(self) weakSelf = self;
    [[HYUkShowLoadingManager sharedInstance] showLoading:-1];
    [[HYVideoSingle sharedInstance] getRnakListWithPage:self.page success:^(NSString *message, id responseObject) {
        [weakSelf.dataArray addObjectsFromArray:responseObject];
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
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = XJFlexibleFont(80);
    CGFloat h = 160 * w / 120 + 20;
    return h;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return XJFlexibleFont(12);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYUkRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HYUkRankViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = 0;
    HYResponseSearchModel *model = self.dataArray[indexPath.section];
    [cell.headImageView yy_setImageWithURL:[NSURL URLWithString:model.vod_pic] placeholder:[UIImage uk_bundleImage:@"uk_image_fail"]];
    cell.name.text = model.vod_name;
    
    NSString *str = @"";
    if (model.type_id_1 == 1) {
        str = @"电影";
    }else if (model.type_id_1 == 2) {
        str = @"电视剧";
    }else if (model.type_id_1 == 3) {
        str = @"综艺";
    }else if (model.type_id_1 == 4) {
        str = @"动漫";
    }else if (model.type_id_1 == 24) {
        str = @"记录片";
    }else {
        str = @"其他";
    }
    
    cell.typeLab.text = [NSString stringWithFormat:@"%@/%@/%@",model.vod_year,str,model.vod_area];
    
    NSString *content = model.vod_content;
    content = [content stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    
    cell.briefLab.text = content;

    if (model.vod_class.length == 0) {
        cell.tagView.hidden = YES;
    }else {
        cell.tagView.data = model.vod_class;
        [cell.tagView loadContent];
        cell.tagView.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    BOOL isOpenTheProxy = [[HYUkVideoConfigManager sharedInstance] isOpenTheProxy];
    if (isOpenTheProxy) {
        [MYToast showWithText:@"请关闭设备代理,否则会播放失败!"];
        return;
    }
    
    HYResponseSearchModel *model = self.dataArray[indexPath.section];

    HYUkDetailViewController *vc = [HYUkDetailViewController new];
    vc.videoId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
