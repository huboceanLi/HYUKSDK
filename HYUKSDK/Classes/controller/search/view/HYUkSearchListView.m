//
//  HYUkSearchListView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/4/28.
//

#import "HYUkSearchListView.h"
#import "HYUkRankViewCell.h"

@interface HYUkSearchListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HYUkSearchListView

- (void)initSubviews {
    [super initSubviews];
    
    self.dataArray = [NSMutableArray array];
    
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
    [self addSubview:self.tableView];
    
    if (@available (iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self);
    }];
}

#pragma mark - Table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        return 70;
//    }
    CGFloat w = XJFlexibleFont(80);
    CGFloat h = 160 * w / 120 + 20;
    return h;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *arr = self.list[section];
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 12.f;
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
    HYResponseSearchModel *model = self.dataArray[indexPath.section];
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@(model.ID)];
    }
}

- (void)loadContent {
    [self.dataArray addObjectsFromArray:self.data];
    [self.tableView reloadData];
}

@end
