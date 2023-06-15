//
//  HYUkCenterHistoryListView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/4.
//

#import "HYUkCenterHistoryListView.h"
#import "HYUkCenterHistoryListViewCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkCenterHistoryListView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HYUkCenterHistoryListView

- (void)initSubviews {
    [super initSubviews];
    self.backgroundColor = UIColor.whiteColor;

    CGFloat leftSpace = 15;

    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
    flow.itemSize = CGSizeMake(XJFlexibleFont(100), XJFlexibleFont(90));
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 6;
    flow.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor =  [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = NO;
    [_collectionView registerClass:[HYUkCenterHistoryListViewCell class] forCellWithReuseIdentifier:@"cell"];
    //    [_collectionView registerNib:[UINib nibWithNibName:@"HYUkVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
}

- (void)loadContent {
    self.dataArray = self.data;
    [self.collectionView reloadData];
}

#pragma mark  --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYUkCenterHistoryListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegate = self;
//
    cell.data = self.dataArray[indexPath.row];
    [cell loadContent];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HYUkHistoryRecordModel *recordModel = self.dataArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@(recordModel.tvId)];
    }
}
@end
