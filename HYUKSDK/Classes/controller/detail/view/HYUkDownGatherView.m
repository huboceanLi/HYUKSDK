//
//  HYUkDownGatherView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/17.
//

#import "HYUkDownGatherView.h"
#import "HYUkHomeCategeryCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkDownGatherView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dowList;
@property (nonatomic, strong) HYUkVideoDetailModel *detailModel;

@end

@implementation HYUkDownGatherView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.name = [UILabel new];
    self.name.text = @"下载";
    self.name.font = [UIFont boldSystemFontOfSize:16];
    self.name.textColor = UIColor.textColor22;
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_offset(50);
        make.top.equalTo(self.mas_top).offset(0);
    }];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage uk_bundleImage:@"uk_video_guanbi"] forState:0];
    [self addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.width.height.mas_equalTo(@(50));
    }];
    
    CGFloat leftSpace = 15;

    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
    flow.itemSize = CGSizeMake(70, 36);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = leftSpace;
    flow.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor =  [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = NO;
    [_collectionView registerClass:[HYUkHomeCategeryCell class] forCellWithReuseIdentifier:@"cell"];

    //    [_collectionView registerNib:[UINib nibWithNibName:@"HYUkVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.name.mas_bottom).offset(0);
    }];
    
    self.dowList = [[[HYUkDownListLogic share] queryDownAllList] mutableCopy];

}

- (void)loadContent
{
    HYUkVideoDetailModel *model = self.data;
    self.detailModel = model;

    [self.collectionView reloadData];
}

- (void)closeButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@{@"type":@"close"}];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.detailModel.vod_play_url.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYUkHomeCategeryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegate = self;
    cell.downImageView.hidden = YES;
    
    HYUkVideoDetailItemModel *model = self.detailModel.vod_play_url[indexPath.row];
    cell.contentView.backgroundColor = UIColor.clearColor;
    cell.backgroundColor = UIColor.clearColor;
    cell.layer.cornerRadius = 0.0;

    cell.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
    cell.name.text = model.name;
    cell.name.textColor = [UIColor textColor22];
    
    if (self.dowList.count > 0) {
        for (HYUkDownListModel *item in self.dowList) {
            if ([model.name isEqualToString:item.playName] || [model.url isEqualToString:item.playUrl]) {
//                cell.name.textColor = [UIColor mainColor];
                cell.downImageView.hidden = NO;
                cell.userInteractionEnabled = NO;
                break;
            }else {
//                cell.name.textColor = [UIColor textColor22];
                cell.userInteractionEnabled = YES;
            }
        }
    }


    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HYUkVideoDetailItemModel *model = self.detailModel.vod_play_url[indexPath.row];

    NSString *str = [NSString stringWithFormat:@"%ld-%@",self.detailModel.ID,model.name];
    
    if ([[HYUkDownListLogic share] queryAppointDownWithPrimaryId:str]) {
        [MYToast showWithText:@"已在下载队列中!"];
        return;
    }
    HYUkDownListModel *downModel = [HYUkDownListModel new];
    downModel.primary_Id = str;
    downModel.video_id = self.detailModel.ID;
    downModel.type_id_1 = self.detailModel.type_id_1;
    downModel.vod_name = self.detailModel.vod_name;
    downModel.vod_pic = self.detailModel.vod_pic;
    downModel.vod_year = self.detailModel.vod_year;
    downModel.vod_area = self.detailModel.vod_area;
    downModel.playName = model.name;
    downModel.playUrl = model.url;
    downModel.content = self.detailModel.vod_content;
    downModel.create_Time = [[[HYUkVideoConfigManager sharedInstance] getNowTimeTimestamp] integerValue];
    [[HYUkDownListLogic share] insertDownListWithModel:downModel];
    
    [self.dowList addObject:downModel];
    
    [[HYUkDownManager sharedInstance] startDown:downModel];

    [MYToast showWithText:@"已添加到下载队列中!"];
    
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil]];

    
//    
//    self.recordModel.playName = model.name;
//    self.recordModel.playUrl = model.url;
//    [self.collectionView reloadData];
//    
//    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
//        [self.delegate customView:self event:@{@"name":model.name,@"url":model.url,@"type":@"change"}];
//    }
}


@end
