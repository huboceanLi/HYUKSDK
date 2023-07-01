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

@interface HYUkOtherViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,HYBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HYUkCategeryListView *categeryListView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) CGFloat headHeight;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HYUkOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = UIColor.clearColor;
//    [[HYVideoPlayTypeManager shareInstance] getPlayTypeLisy];
    self.headHeight = XJFlexibleFont(200);
    
    CGFloat leftSpace = 15;
    CGFloat space = 8;
    NSInteger count = 3;
    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
    CGFloat h = 160 * w / 120 + 6 + 20;
        
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(leftSpace, leftSpace, leftSpace, leftSpace);
    flow.itemSize = CGSizeMake(w, h);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = IS_IPAD ? space * 3 : space;
    flow.minimumInteritemSpacing = space;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor =  [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = NO;
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, (IS_iPhoneX ? 34 : 0), 0)];
    [self.collectionView registerClass:[HYUkVideoHomeListCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView updateEmptyViewWithImageName:@"uk_nodata" title:@"暂无数据"];
    self.collectionView.emptyView.verticalOffset = 50;
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    [self getData];
    
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf getData];
    }];
}

- (void)getData {
    __weak typeof(self) weakSelf = self;

    CGFloat oy = (SCREEN_HEIGHT - self.headHeight - (IS_iPhoneX ? 168 : 114) - (SCREEN_WIDTH / 5.0)) / 2.0 + (IS_iPhoneX ? 88 : 64) + self.headHeight;
    
    if (self.page == 0) {
        [[HYUkShowLoadingManager sharedInstance] showLoading:oy];
    }
        
    [[HYVideoSingle sharedInstance] getVideoListWithPage:self.page type_id_1:self.categeryModel.ID type_id:self.categeryListView.tempCategaryModel.type_id vod_area:self.categeryListView.tempCategaryModel.vod_area vod_lang:self.categeryListView.tempCategaryModel.vod_lang vod_year:self.categeryListView.tempCategaryModel.vod_year order:self.categeryListView.tempCategaryModel.order success:^(NSString *message, id responseObject) {
        NSArray *a = responseObject;
        [weakSelf.dataArray addObjectsFromArray:responseObject];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView updateEmptyViewWithImageName:@"uk_nodata" title:@"暂无数据"];
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        if (a.count == 0) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];;
        }
        
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        if (errorType == CTAPIManagerErrorTypeNoNetWork) {
            [weakSelf.collectionView updateEmptyViewWithImageName:@"uk_net_err" title:errorMessage];
        }else {
            [weakSelf.collectionView updateEmptyViewWithImageName:@"uk_load_err" title:@"加载失败!"];
        }
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
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

    HYResponseVideoListModel *model = self.dataArray[indexPath.row];

    [cell.headImageView yy_setImageWithURL:[NSURL URLWithString:model.vod_pic] placeholder:[UIImage uk_bundleImage:@"uk_image_fail"]];
    cell.name.text = model.vod_name;
    cell.des.hidden = YES;
    if (model.vod_remarks.length > 0) {
        cell.des.hidden = NO;
        cell.des.text = model.vod_remarks;
    }
    cell.scoreLab.text = model.vod_douban_score;
    [[HYUkVideoConfigManager sharedInstance] changeScoreColor:model.vod_douban_score Label:cell.scoreLab];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isOpenTheProxy = [[HYUkVideoConfigManager sharedInstance] isOpenTheProxy];
    if (isOpenTheProxy) {
        [MYToast showWithText:@"请关闭设备代理,否则会播放失败!"];
        return;
    }
    HYResponseVideoListModel *model = self.dataArray[indexPath.row];
    HYUkDetailViewController *vc = [HYUkDetailViewController new];
    vc.videoId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, self.headHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headView.backgroundColor = UIColor.clearColor;
//        [headView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

        if (!self.categeryListView) {
            self.categeryListView = [[HYUkCategeryListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.headHeight)];
            self.categeryListView.delegate = self;
            [headView addSubview:self.categeryListView];
            self.categeryListView.data = self.categeryModel;
            [self.categeryListView loadContent];
        }


        return headView;
    }
    return nil;
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    if ([view isKindOfClass:[HYUkCategeryListView class]]) {
        
        NSDictionary *dic = event;
        if ([dic[@"type"] isEqualToString:@"h"]) {
            NSInteger index = [dic[@"h"] intValue];
            self.headHeight = XJFlexibleFont(40) * index;
            [self.collectionView updateEmptyViewWithImageName:@"" title:@""];
            [self.collectionView reloadData];
        }else {
            self.page = 0;
            [self.dataArray removeAllObjects];
            [self.collectionView updateEmptyViewWithImageName:@"" title:@""];
            [self.collectionView reloadData];
            [self getData];
        }

    }
}

@end
