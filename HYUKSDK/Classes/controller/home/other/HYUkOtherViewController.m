//
//  HYUkOtherViewController.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkOtherViewController.h"
#import "HYUkDetailViewController.h"
#import "HYUkVideoHomeListCell.h"
#import "HYUkCategeryListView.h"

@interface HYUkOtherViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HYUkCategeryListView *categeryListView;
@property (nonatomic, assign) NSInteger page;

@end

@implementation HYUkOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = UIColor.clearColor;
//    [[HYVideoPlayTypeManager shareInstance] getPlayTypeLisy];
    
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
    
    [self getData];
}

- (void)getData {
    __weak typeof(self) weakSelf = self;
    [[HYVideoSingle sharedInstance] getVideoListWithPage:self.page type_id_1:self.categeryModel.ID vod_area:@"" vod_lang:@"" vod_year:@"" order:@"最新" success:^(NSString *message, id responseObject) {
        [weakSelf.dataArray addObjectsFromArray:responseObject];
        [weakSelf.collectionView reloadData];
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
            
    }];
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
    
    HYUkVideoHomeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegate = self;
//
//    cell.data =
//    [cell loadContent];

//    HYDouBanMovieItemModel *model = self.dataArray[indexPath.row];
//
//    [cell.headImageView setImageWithURL:[NSURL URLWithString:model.pic.large] placeholder:nil];
//    cell.name.text = model.title;
    HYResponseVideoListModel *model = self.dataArray[indexPath.row];

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
    HYResponseVideoListModel *model = self.dataArray[indexPath.row];
    HYUkDetailViewController *vc = [HYUkDetailViewController new];
    vc.videoId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 200);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headView.backgroundColor = UIColor.clearColor;
//        [headView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

        if (!self.categeryListView) {
            self.categeryListView = [[HYUkCategeryListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
            [headView addSubview:self.categeryListView];
            self.categeryListView.data = self.categeryModel;
            [self.categeryListView loadContent];
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

@end
