//
//  HYUkRecommendListView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

#import "HYUkRecommendListView.h"
#import "HYUkVideoHomeListCell.h"
#import "HYResponseRecommendModel.h"

@interface HYUkRecommendListView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HYUkRecommendListView

- (void)initSubviews {
    [super initSubviews];
    self.backgroundColor = UIColor.clearColor;
    
    CGFloat leftSpace = 15;
    CGFloat space = 8;
    NSInteger count = 3;
    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
    CGFloat h = 160 * w / 120 + 6 + 20;
    
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
        make.top.bottom.left.right.equalTo(self);
//        make.top.equalTo(self.navBar.mas_bottom).offset(0);
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

    [cell.headImageView setImageWithURL:[NSURL URLWithString:model.vod_pic] placeholder:nil];
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
//    HYUkDetailViewController *vc = [HYUkDetailViewController new];
//    vc.movieModel = self.dataArray[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(SCREEN_WIDTH, 50);
//}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if (kind == UICollectionElementKindSectionHeader) {
//
//        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
//        headView.backgroundColor = UIColor.clearColor;
////        [headView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
//
////        if (!self.videoHeadView) {
////            self.videoHeadView = [[HYHomeVideoHeadView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, self.headHeight - 20.0)];
////            [headView addSubview:self.videoHeadView];
////
////            __weak typeof(self) _self = self;
////
////            [self.videoHeadView setHeadHeightBlock:^(CGFloat headHeight) {
////                _self.headHeight = headHeight + 20;
////                [_self.collectionView reloadData];
////            }];
////
////            [self.videoHeadView setMovieListBlock:^(NSArray * _Nonnull list) {
////                [_self.dataArray addObjectsFromArray:list];
////                [_self.collectionView reloadData];
////            }];
////        }
//
//
//        return headView;
//    }
//    return nil;
//}

- (void)loadContent {
    self.dataArray = self.data;
    [self.collectionView reloadData];
}

@end
