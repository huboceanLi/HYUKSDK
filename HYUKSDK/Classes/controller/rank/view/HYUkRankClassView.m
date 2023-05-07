//
//  HYUkRankClassView.m
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/7.
//

#import "HYUkRankClassView.h"
#import "HYUkHomeCategeryCell.h"


@interface HYUkRankClassView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HYUkRankClassView

- (void)initSubviews {
    [super initSubviews];
    
    CGFloat leftSpace = 15;
    CGFloat space = 8;

    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, leftSpace);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = space;
    flow.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor =  [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = NO;
    [_collectionView registerClass:[HYUkHomeCategeryCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

#pragma mark  --- UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYUkTextTempModel *m = self.dataArray[indexPath.row];
    return CGSizeMake(m.nameWidth, 20);
}
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
    HYUkHomeCategeryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    HYUkTextTempModel *m = self.dataArray[indexPath.row];

    cell.name.text = m.name;
    cell.userInteractionEnabled = NO;
    
    cell.contentView.backgroundColor = UIColor.clearColor;
    cell.backgroundColor = UIColor.clearColor;
    cell.layer.cornerRadius = 0.0;
    cell.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:self.dataArray[indexPath.row]];
    }
}

- (void)loadContent {
    self.dataArray = [NSMutableArray array];

    NSString *str = self.data;
    NSArray *array = [str componentsSeparatedByString:@","];
    NSInteger index = array.count;
    if (index >= 3) {
        index = 3;
    }
    
    for (int i = 0; i < index; i++) {
        NSString *item = array[i];
        HYUkTextTempModel *m = [HYUkTextTempModel new];
        m.name = item;
        m.nameFont = [UIFont systemFontOfSize:13];
        [self.dataArray addObject:m];
    }
    [self.collectionView reloadData];
}

@end
