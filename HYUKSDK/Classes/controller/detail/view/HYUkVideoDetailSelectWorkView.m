//
//  HYUkVideoDetailSelectWorkView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYUkVideoDetailSelectWorkView.h"
#import "HYUkHomeCategeryCell.h"

@interface HYUkVideoDetailSelectWorkView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) QMUIButton *moreBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HYUkVideoDetailModel *detailModel;

@end

@implementation HYUkVideoDetailSelectWorkView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.name = [UILabel new];
    self.name.text = @"选集";
    self.name.font = [UIFont boldSystemFontOfSize:16];
    self.name.textColor = UIColor.textColor22;
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_offset(50);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.moreBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setTitle:@"更多" forState:0];
    [self.moreBtn setTitleColor:UIColor.textColor99 forState:0];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.moreBtn setImage:[UIImage uk_bundleImage:@"jinrujiantou"] forState:0];
    [self.moreBtn setImagePosition:QMUIButtonImagePositionRight];
    self.moreBtn.spacingBetweenImageAndTitle = 0;
    [self addSubview:self.moreBtn];
    [self.moreBtn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-8);
        make.top.equalTo(self.mas_top).offset(12);
        make.height.mas_offset(20);
    }];
    
    CGFloat leftSpace = 15;

    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
    flow.itemSize = CGSizeMake(70, 36);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = leftSpace;
    flow.minimumInteritemSpacing = 0;
//    flow.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 100);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor =  [UIColor clearColor];
    //    _collectionView.scrollEnabled = YES;
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
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return 11;
    return self.detailModel.vod_play_url.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYUkHomeCategeryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegate = self;

    HYUkVideoDetailItemModel *model = self.detailModel.vod_play_url[indexPath.row];
//    cell.data = self.dataArray[indexPath.row];
//    [cell loadContent];
    cell.contentView.backgroundColor = UIColor.clearColor;
    cell.backgroundColor = UIColor.clearColor;
    cell.layer.cornerRadius = 0.0;

    cell.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
    cell.name.text = model.name;
    
//    if (self.recordIndex == indexPath.row) {
//        cell.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.1];
//        cell.name.textColor = [UIColor whiteColor];
//    }else {
//        cell.backgroundColor = UIColor.clearColor;
//        cell.name.textColor = [UIColor textColor22];
//    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
