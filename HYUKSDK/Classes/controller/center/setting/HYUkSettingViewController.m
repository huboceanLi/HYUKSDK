//
//  HYUkSettingViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import "HYUkSettingViewController.h"
#import "HYUkSettingCell.h"

@interface HYUkSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation HYUkSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.whiteColor;
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    self.navTitleLabel.text = @"设置";
    self.navTitleLabel.textColor = UIColor.textColor22;
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"uk_back"] forState:0];
    
    
    self.dataArray = @[@[@"允许流量播放",@"允许流量下载",@"免责申明",@"隐私政策",@"清除缓存",@"联系我们"],@[@"我的账号",@"修改密码",@"退出账号"]];
    self.imageArray = @[@[@"uk_setting_play",@"uk_setting_download",@"uk_setting_declare",@"uk_setting_yinsi",@"uk_setting_clear",@"uk_setting_contact"],@[@"uk_setting_account",@"uk_setting_key",@"uk_setting_exit"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 15, 0)];
    [ _tableView registerClass:[HYUkSettingCell class] forCellReuseIdentifier:@"Cell"];

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
}

#pragma mark - Table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 0.01;
    }
    return 12.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 12)];
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    return lineView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *arr = self.dataArray[section];
    
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYUkSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HYUkSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = 0;
    cell.playSwitch.hidden = YES;
    cell.arrowImageView.hidden = YES;
    cell.briefLab.hidden = YES;

    if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1)) {
        cell.playSwitch.hidden = NO;
    }else {
        cell.arrowImageView.hidden = NO;
        cell.briefLab.hidden = NO;
    }

    
    NSArray *arr = self.dataArray[indexPath.section];
    NSArray *imgArr = self.imageArray[indexPath.section];

    cell.name.text = arr[indexPath.row];
    cell.headImageView.image = [UIImage uk_bundleImage:imgArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


@end
