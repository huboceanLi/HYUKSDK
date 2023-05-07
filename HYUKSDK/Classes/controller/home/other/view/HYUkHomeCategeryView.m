//
//  HYUkHomeCategeryView.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/24.
//

#import "HYUkHomeCategeryView.h"
#import "HYUkHomeCategeryCell.h"

@interface HYUkHomeCategeryView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger recordIndex;

@end

@implementation HYUkHomeCategeryView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;

    CGFloat leftSpace = 15;
    CGFloat space = 8;

    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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

    //    [_collectionView registerNib:[UINib nibWithNibName:@"HYUkVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(28);
    }];
}

#pragma mark  --- UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYUkTextTempModel *m = self.dataArray[indexPath.row];
    return CGSizeMake(m.nameWidth, 30);
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
    if (self.recordIndex == indexPath.row) {
        cell.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.1];
        cell.name.textColor = [UIColor whiteColor];
    }else {
        cell.backgroundColor = UIColor.clearColor;
        cell.name.textColor = [UIColor textColor22];
    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.recordIndex = indexPath.row;
    [self.collectionView reloadData];
    
    NSIndexPath *cuIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];  //取最后一行数据
    [self.collectionView scrollToItemAtIndexPath:cuIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    HYUkTextTempModel *m = self.dataArray[indexPath.row];

    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:m.name];
    }
}

- (void)loadContent {
    
    NSMutableArray *temArray = [NSMutableArray array];
    NSArray *a = self.data;
    for (int i = 0; i < a.count; i++) {
        NSString *item = a[i];
        HYUkTextTempModel *m = [HYUkTextTempModel new];
        m.name = item;
        m.nameFont = [UIFont systemFontOfSize:13];
        [temArray addObject:m];
    }
    self.dataArray = [temArray mutableCopy];
    [self.collectionView reloadData];
}

@end
