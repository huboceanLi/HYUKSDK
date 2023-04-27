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
//    NSInteger count = 3;
//    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
//    CGFloat h = 160 * w / 120 + 6 + 20;
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
//    flow.itemSize = CGSizeMake(w, h);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
    
    return CGSizeMake(60, 30);

//    HYDouBanCategeryTempModel *m = self.dataArray[indexPath.row];
//    return CGSizeMake(m.cellWidth, 30);
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
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
//    cell.delegate = self;

//    cell.data = self.dataArray[indexPath.row];
//    [cell loadContent];
    cell.name.text = self.dataArray[indexPath.row];
    
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
}

- (void)loadContent {
    
//    NSMutableArray *temArray = [NSMutableArray array];
//
//    NSArray *a = self.data;
//
//    for (int i = 0; i < a.count; i++) {
//        NSString *item = a[i];
//        HYDouBanCategeryTempModel *m = [HYDouBanCategeryTempModel new];
//
//        if (i == 0) {
//            if ([item containsString:@"全部"]) {
//                m.name = @"全部";
//            }
//        }
////        else if ([item containsString:@"年代"]) {
////            m.name = [NSString stringWithFormat:@"%@年",[item substringToIndex:item.length - 2]];
////        }
//        else {
//            m.name = item;
//        }
//        CGFloat w = [m.name widthForFont:[UIFont systemFontOfSize:13]];
//
//        m.cellWidth = ceil(w) + 20;
//
//        [temArray addObject:m];
//    }
//
//    self.dataArray = [temArray mutableCopy];
//
//    [self.collectionView reloadData];
    self.dataArray = self.data;
    [self.collectionView reloadData];
}

@end
