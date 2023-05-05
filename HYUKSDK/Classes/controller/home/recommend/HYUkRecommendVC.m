//
//  HYUkRecommendVC.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkRecommendVC.h"
#import "HYUkDetailViewController.h"
#import "HYUkVideoHomeListCell.h"
#import "HYUkRecommendHeadView.h"

@interface HYUkRecommendVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HYUkRecommendHeadView *recommendHeadView;

@end

@implementation HYUkRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.clearColor;
    
    self.dataArray = [NSMutableArray array];
    
//    [[HYVideoPlayTypeManager shareInstance] getPlayTypeLisy];
}
- (void)initSubviews
{
    [super initSubviews];
    
    CGFloat leftSpace = 15;
    CGFloat space = 8;
    NSInteger count = 3;
    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
    CGFloat h = 160 * w / 120 + 6 + 20;
    
//    self.headHeight = 140.0;
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(leftSpace, leftSpace, leftSpace, leftSpace);
    flow.itemSize = CGSizeMake(w, h);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = space;
    flow.minimumInteritemSpacing = space;
//    flow.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 100);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor =  [UIColor clearColor];
    //    self.collectionView.scrollEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = NO;
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, (IS_iPhoneX ? 34 : 0), 0)];
    [self.collectionView registerClass:[HYUkVideoHomeListCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    //    [self.collectionView registerNib:[UINib nibWithNibName:@"HYUkVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
//        make.top.equalTo(self.navBar.mas_bottom).offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).offset(- (IS_iPhoneX ? 80 : 50));
    }];

    [[HYUkShowLoadingManager sharedInstance] showLoading:self.collectionView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[HYUkShowLoadingManager sharedInstance] showLoading:self.collectionView];
        });
    });
}
#pragma mark  --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
//    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYUkVideoHomeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
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
    HYUkDetailViewController *vc = [HYUkDetailViewController new];
//    vc.movieModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 100);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headView.backgroundColor = UIColor.clearColor;
//        [headView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

//        if (!self.videoHeadView) {
//            self.videoHeadView = [[HYHomeVideoHeadView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, self.headHeight - 20.0)];
//            [headView addSubview:self.videoHeadView];
//
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
//        }


        return headView;
    }
    return nil;
}

@end
