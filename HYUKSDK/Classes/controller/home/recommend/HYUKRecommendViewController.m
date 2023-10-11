//
//  HYUKRecommendViewController.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/10/11.
//

#import "HYUKRecommendViewController.h"
#import "HYUkVideoHomeListCell.h"
#import "HYResponseRecommendModel.h"
#import "HYUkHeader.h"
#import "HYUkRecommendHeadView.h"
#import "HYUkDetailViewController.h"


@interface HYUKRecommendViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dataDic;

@end

@implementation HYUKRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat leftSpace = 15;
    CGFloat space = XJFlexibleFont(8);
    NSInteger count = 3;
    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
    CGFloat h = 160 * w / 120 + 6 + 20;
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
    flow.itemSize = CGSizeMake(w, h);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = space;
    flow.minimumInteritemSpacing = 0;
    flow.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 44.0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor =  [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = NO;
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, bottomSafeAreaHeight_HEIGHT, 0)];
    [self.collectionView registerClass:[HYUkVideoHomeListCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getData];
    });
}

- (void)getData {
    
    [[HYUkShowLoadingManager sharedInstance] showLoading:-1];

    __weak typeof(self) weakSelf = self;
    [[HYVideoSingle sharedInstance] homeRecommendWithListSuccess:^(NSString *message, id responseObject) {
        NSArray *models = responseObject;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (HYResponseRecommendModel * item in models) {
            
            NSString *tid = [NSString stringWithFormat:@"%ld",item.type_id_1];
            
            if ([dic.allKeys containsObject:tid]) {
                NSMutableArray *itemArr = [NSMutableArray array];
                itemArr = [dic[tid] mutableCopy];
                [itemArr addObject:item];
                [dic setObject:itemArr forKey:tid];
            }else {
                [dic setObject:@[item] forKey:tid];
            }
        }
        weakSelf.dataDic = [dic mutableCopy];
        [weakSelf.collectionView reloadData];
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        if (errorType == CTAPIManagerErrorTypeNoNetWork) {
            [weakSelf.collectionView updateEmptyViewWithImageName:@"uk_net_err" title:errorMessage];
        }else {
            [weakSelf.collectionView updateEmptyViewWithImageName:@"uk_load_err" title:@"加载失败!"];
        }
        [weakSelf.collectionView reloadData];
        [[HYUkShowLoadingManager sharedInstance] removeLoading];
    }];
}

#pragma mark  --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataDic.allKeys.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr = self.dataDic.allKeys;
    if ([arr containsObject:@"1"] && section == 0) {
        NSArray *da = self.dataDic[@"1"];
        return da.count;
    }
    
    if ([arr containsObject:@"2"] && section == 1) {
        NSArray *da = self.dataDic[@"2"];
        return da.count;
    }
    
    if ([arr containsObject:@"3"] && section == 2) {
        NSArray *da = self.dataDic[@"3"];
        return da.count;
    }
    
    if ([arr containsObject:@"4"] && section == 3) {
        NSArray *da = self.dataDic[@"4"];
        return da.count;
    }
    
    if ([arr containsObject:@"24"] && section == 4) {
        NSArray *da = self.dataDic[@"24"];
        return da.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYUkVideoHomeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    NSArray *arr = self.dataDic.allKeys;
    NSArray *modelArray = @[];
    
    if ([arr containsObject:@"1"] && indexPath.section == 0) {
        modelArray = self.dataDic[@"1"];
    }
    
    if ([arr containsObject:@"2"] && indexPath.section == 1) {
        modelArray = self.dataDic[@"2"];
    }
    
    if ([arr containsObject:@"3"] && indexPath.section == 2) {
        modelArray = self.dataDic[@"3"];
    }
    
    if ([arr containsObject:@"4"] && indexPath.section == 3) {
        modelArray = self.dataDic[@"4"];
    }
    
    if ([arr containsObject:@"24"] && indexPath.section == 4) {
        modelArray = self.dataDic[@"24"];
    }
    
    HYResponseRecommendModel *model = modelArray[indexPath.row];

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
    NSArray *arr = self.dataDic.allKeys;
    NSArray *modelArray = @[];
    
    if ([arr containsObject:@"1"] && indexPath.section == 0) {
        modelArray = self.dataDic[@"1"];
    }
    
    if ([arr containsObject:@"2"] && indexPath.section == 1) {
        modelArray = self.dataDic[@"2"];
    }
    
    if ([arr containsObject:@"3"] && indexPath.section == 2) {
        modelArray = self.dataDic[@"3"];
    }
    
    if ([arr containsObject:@"4"] && indexPath.section == 3) {
        modelArray = self.dataDic[@"4"];
    }
    
    if ([arr containsObject:@"24"] && indexPath.section == 4) {
        modelArray = self.dataDic[@"24"];
    }
    HYResponseRecommendModel *model = modelArray[indexPath.row];

    HYUkDetailViewController *vc = [HYUkDetailViewController new];
    vc.videoId = model.video_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headView.backgroundColor = UIColor.clearColor;
        [headView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

        HYUkRecommendHeadView *recommendHeadView = [[HYUkRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.0)];
        [headView addSubview:recommendHeadView];
            
        [recommendHeadView showTitle:indexPath.section dic:self.dataDic];

        return headView;
    }
    return nil;
}

@end
