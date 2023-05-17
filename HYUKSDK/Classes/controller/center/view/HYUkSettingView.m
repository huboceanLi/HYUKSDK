//
//  HYUkSettingView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/15.
//

#import "HYUkSettingView.h"
#import "HYUkSettingCell.h"

@interface HYUkSettingView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation HYUkSettingView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initSubviews {
    [super initSubviews];
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 12.0;
    self.layer.masksToBounds = YES;
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:16];
    self.name.textColor = UIColor.textColor22;
    self.name.text = @"设置";
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_offset(50);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.dataArray = @[@"允许流量播放和下载",@"免责申明",@"隐私政策",@"清除缓存",@"联系我们"];
    self.imageArray = @[@"uk_setting_play",@"uk_setting_declare",@"uk_setting_yinsi",@"uk_setting_clear",@"uk_setting_contact"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 15, 0)];
    [ _tableView registerClass:[HYUkSettingCell class] forCellReuseIdentifier:@"Cell"];

//    [self.tableView registerNib:[UINib nibWithNibName:@"ChangeInfoCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self addSubview:self.tableView];
    
    if (@available (iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.name.mas_bottom);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-(IS_iPhoneX ? 88 : 64));
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flowPlayNotic) name:video_allow_flow_play object:nil];

}

- (void)flowPlayNotic {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];

}

#pragma mark - Table view datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYUkSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HYUkSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = 0;
    cell.playSwitch.hidden = YES;
    cell.arrowImageView.hidden = NO;
    cell.briefLab.hidden = YES;

    if (indexPath.row == 0 || indexPath.row == 1) {
        cell.playSwitch.hidden = NO;
        cell.arrowImageView.hidden = YES;
    }else if (indexPath.row == 4 || indexPath.row == 5) {
        cell.briefLab.hidden = NO;
    }

    cell.name.text = self.dataArray[indexPath.row];
    cell.headImageView.image = [UIImage uk_bundleImage:self.imageArray[indexPath.row]];
    cell.playSwitch.tag = indexPath.row;
    [cell.playSwitch addTarget:self action:@selector(playSwitchClick:) forControlEvents:UIControlEventTouchUpInside];

    if (indexPath.row == 0) {
        if ([UserDefault boolValueForKey:video_allow_flow_play]) {
            cell.playSwitch.on = YES;
        }else {
            cell.playSwitch.on = NO;
        }
    }

    
    return cell;
}

- (void)playSwitchClick:(UISwitch *)sender {
    if (sender.tag == 0) {
        if ([UserDefault boolValueForKey:video_allow_flow_play]) {
            [UserDefault setBool:false forKey:video_allow_flow_play];
        }else {
            [UserDefault setBool:true forKey:video_allow_flow_play];
        }
        return;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    

}

@end
