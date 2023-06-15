//
//  HYUkVideoDetailSelectWorkView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYUkVideoDetailSelectWorkView.h"
#import "HYUkHomeCategeryCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkVideoDetailSelectWorkView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) QMUIButton *moreBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HYUkVideoDetailModel *detailModel;
@property (nonatomic, strong) HYUkHistoryRecordModel *recordModel;

@end

@implementation HYUkVideoDetailSelectWorkView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.name = [UILabel new];
    self.name.text = @"选集";
    self.name.font = [UIFont boldSystemFontOfSize:XJFlexibleFont(16)];
    self.name.textColor = UIColor.textColor22;
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_offset(XJFlexibleFont(50));
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.moreBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setTitle:@"更多" forState:0];
    [self.moreBtn setTitleColor:UIColor.textColor99 forState:0];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(13)];
    [self.moreBtn setImage:[UIImage uk_bundleImage:@"uk_video_arrow"] forState:0];
    [self.moreBtn setImagePosition:QMUIButtonImagePositionRight];
    self.moreBtn.spacingBetweenImageAndTitle = 0;
    [self addSubview:self.moreBtn];
    [self.moreBtn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-XJFlexibleFont(8));
        make.top.equalTo(self.mas_top).offset(XJFlexibleFont(12));
        make.height.mas_offset(XJFlexibleFont(20));
    }];
    
    CGFloat leftSpace = 15;

    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
    flow.itemSize = CGSizeMake(70, 36);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
        make.left.right.equalTo(self);
        make.height.mas_equalTo(36);
        make.top.equalTo(self.name.mas_bottom).offset(10);
    }];
}

- (void)loadContent
{
    HYUkVideoDetailModel *model = self.data;
    self.detailModel = model;
    if (model.vod_play_url.count <= 1) {
        self.moreBtn.hidden = YES;
    }else {
        self.moreBtn.hidden = NO;
    }
    [self.collectionView reloadData];
}

- (void)moreButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@{@"type":@"more"}];
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

    HYUkVideoDetailItemModel *model = self.detailModel.vod_play_url[indexPath.row];
    cell.contentView.backgroundColor = UIColor.clearColor;
    cell.backgroundColor = UIColor.clearColor;
    cell.layer.cornerRadius = 0.0;

    cell.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
    cell.name.text = model.name;

    if ([model.name isEqualToString:self.recordModel.playName] || [model.url isEqualToString:self.recordModel.playUrl]) {
        cell.name.textColor = [UIColor mainColor];
        cell.userInteractionEnabled = NO;
    }else {
        cell.name.textColor = [UIColor textColor22];
        cell.userInteractionEnabled = YES;
    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HYUkVideoDetailItemModel *model = self.detailModel.vod_play_url[indexPath.row];
    self.recordModel.playName = model.name;
    self.recordModel.playUrl = model.url;
    [self.collectionView reloadData];
    
    NSIndexPath *cuIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];  //取最后一行数据
    [self.collectionView scrollToItemAtIndexPath:cuIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@{@"name":model.name,@"url":model.url,@"type":@"change"}];
    }
}

- (void)changeSelect:(HYUkHistoryRecordModel *)recordModel
{
    self.recordModel = recordModel;
    
    [self.collectionView reloadData];
}

@end
