//
//  HYUkVideoRecommendView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYUkVideoRecommendView.h"
#import "HYUkVideoHomeListCell.h"
#import "HYResponseRecommendModel.h"

@interface HYUkVideoRecommendView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UILabel *name;

@end

@implementation HYUkVideoRecommendView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:16];
    self.name.textColor = UIColor.textColor22;
    self.name.text = @"猜你喜欢";
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_offset(50);
        make.top.equalTo(self.mas_top).offset(0);
    }];

    CGFloat leftSpace = 15;
    CGFloat space = 8;
    CGFloat w = 110 * 120 / 160;
    CGFloat h = 110 + 6 + 20;
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
    flow.itemSize = CGSizeMake(w, h);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = space;
    flow.minimumInteritemSpacing = 0;
//    flow.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 100);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor =  [UIColor clearColor];
    //    self.collectionView.scrollEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = NO;
//    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, (IS_iPhoneX ? 34 : 0), 0)];
    [self.collectionView registerClass:[HYUkVideoHomeListCell class] forCellWithReuseIdentifier:@"cell"];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    //    [self.collectionView registerNib:[UINib nibWithNibName:@"HYUkVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(self.name.mas_bottom).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(- (IS_iPhoneX ? 80 : 50));
    }];
}

#pragma mark  --- UICollectionViewDataSource
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return self.dataDic.allKeys.count;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYUkVideoHomeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    HYResponseRecommendModel *model = self.dataArray[indexPath.row];

    [cell.headImageView setImageWithURL:[NSURL URLWithString:model.vod_pic] placeholder:[UIImage uk_bundleImage:@"uk_image_fail"]];
//
//    __block HYUkVideoHomeListCell *strongBlock = cell;
//    [cell.headImageView setImageWithURL:[NSURL URLWithString:model.vod_pic] placeholder:nil options:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//        if (error) {
//            strongBlock.headImageView.image = [UIImage uk_bundleImage:@"uk_image_fail"];
//        }
//    }];
    
    cell.name.text = model.vod_name;
    cell.des.hidden = YES;
    if (model.vod_remarks.length > 0) {
        cell.des.hidden = NO;
        cell.des.text = model.vod_remarks;
    }
    cell.scoreLab.text = model.vod_douban_score;
    [[HYUkConfigManager sharedInstance] changeScoreColor:model.vod_douban_score Label:cell.scoreLab];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:self.dataArray[indexPath.row]];
    }
    
//    HYUkDetailViewController *vc = [HYUkDetailViewController new];
//    vc.movieModel = self.dataArray[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadContent {
    self.dataArray = self.data;
    [self.collectionView reloadData];
}


@end
