//
//  HYUkCenterHistoryListView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/4.
//

#import "HYUkCenterHistoryListView.h"
#import "HYUkCenterHistoryListViewCell.h"

@interface HYUkCenterHistoryListView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HYUkCenterHistoryListView

- (void)initSubviews {
    [super initSubviews];
    self.backgroundColor = UIColor.whiteColor;
    
    self.dataArray = [NSMutableArray array];
    
//    [[HYVideoPlayTypeManager shareInstance] getPlayTypeLisy];
    
    CGFloat leftSpace = 15;
//    CGFloat space = 8;
//    NSInteger count = 3;
//    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
//    CGFloat h = 160 * w / 120 + 6 + 20;
    
//    self.headHeight = 140.0;
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
    flow.itemSize = CGSizeMake(100, 90);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 6;
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
//    [_collectionView setContentInset:UIEdgeInsetsMake(0, 0, (IS_iPhoneX ? 34 : 0), 0)];
    [_collectionView registerClass:[HYUkCenterHistoryListViewCell class] forCellWithReuseIdentifier:@"cell"];
    //    [_collectionView registerNib:[UINib nibWithNibName:@"HYUkVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
//        make.top.equalTo(self.navBar.mas_bottom).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(- (IS_iPhoneX ? 80 : 50));
    }];
}

#pragma mark  --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;

//    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYUkCenterHistoryListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegate = self;
//
//    cell.data =
//    [cell loadContent];

//    HYDouBanMovieItemModel *model = self.dataArray[indexPath.row];
//
//    [cell.headImageView setImageWithURL:[NSURL URLWithString:model.pic.large] placeholder:nil];
//    cell.name.text = model.title;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
