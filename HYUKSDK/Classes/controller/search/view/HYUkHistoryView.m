//
//  HYUkHistoryView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/4/28.
//

#import "HYUkHistoryView.h"
#import "HYUkHomeCategeryCell.h"
#import "HYUkHistoryHeadView.h"

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
    self.dataArray = @[@"阿斯顿发",@"多少啊",@"伟大",@"藤森方式发生",@"u他月黑风高的",@"让我通过发送",@"公司人士",@"问",@"染发",@"我儿氛围啊",@"饿饿哒"];
    
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
}

#pragma mark  --- UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(70, 30);

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
    
    cell.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.1];
    cell.name.textColor = [UIColor whiteColor];

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
    return CGSizeMake(SCREEN_WIDTH, 70);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headView.backgroundColor = UIColor.clearColor;
//        [headView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

        if (!self.historyHeadView) {
            self.historyHeadView = [[HYUkHistoryHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
            [headView addSubview:self.historyHeadView];

//            __weak typeof(self) _self = self;
//
//            [self.videoHeadView setHeadHeightBlock:^(CGFloat headHeight) {
//                _self.headHeight = headHeight + 20;
//                [_self.collectionView reloadData];
//            }];
//
//            [self.videoHeadView setMovieListBlock:^(NSArray * _Nonnull list) {
//                [_self.dataArray addObjectsFromArray:list];
//                [_self.collectionView reloadData];
//            }];
        }


        return headView;
    }
    return nil;
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
