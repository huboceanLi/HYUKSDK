//
//  HYUkHistoryView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/4/28.
//

#import "HYUkHistoryView.h"
#import "HYUkHomeCategeryCell.h"
#import "HYUkHistoryHeadView.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkHistoryView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) HYUkHistoryHeadView *historyHeadView;

@end

@implementation HYUkHistoryView

- (void)initSubviews {
    [super initSubviews];
    
    CGFloat leftSpace = 15;
    CGFloat space = 8;
//    NSInteger count = 3;
//    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
//    CGFloat h = 160 * w / 120 + 6 + 20;
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
//    flow.itemSize = CGSizeMake(w, h);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = space;
    flow.minimumInteritemSpacing = space;
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
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];

    //    [_collectionView registerNib:[UINib nibWithNibName:@"HYUkVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
//        make.height.mas_equalTo(28);
    }];
    [self loadContent];
    
}

- (void)clearButtonClick {
    [[HYVideoSearchLogic share] clearData];
    [self loadContent];
}
#pragma mark  --- UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    return CGSizeMake(70, 30);
    HYUkTextTempModel *m = self.dataArray[indexPath.row];
    return CGSizeMake(m.nameWidth, XJFlexibleFont(30));
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return 11;
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYUkHomeCategeryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    HYUkTextTempModel *m = self.dataArray[indexPath.row];
    cell.name.text = m.name;
    
    cell.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.1];
    cell.name.textColor = [UIColor textColor22];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:self.dataArray[indexPath.row]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, XJFlexibleFont(70));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headView.backgroundColor = UIColor.clearColor;

        if (!self.historyHeadView) {
            self.historyHeadView = [[HYUkHistoryHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, XJFlexibleFont(70))];
            [headView addSubview:self.historyHeadView];
            [self.historyHeadView.clearBtn addTarget:self action:@selector(clearButtonClick) forControlEvents:UIControlEventTouchUpInside];

        }


        return headView;
    }
    return nil;
}

- (void)loadContent {
    
    NSArray *arr = [[HYVideoSearchLogic share] querySearchList];
    
    NSMutableArray *temArray = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSString *item = arr[i];
        HYUkTextTempModel *m = [HYUkTextTempModel new];
        m.name = item;
        m.nameFont = [UIFont systemFontOfSize:XJFlexibleFont(13)];
        [temArray addObject:m];
    }
    self.dataArray = [temArray mutableCopy];
    
    [self.collectionView reloadData];
}


@end
