//
//  HYUkBaseListViewController.h
//  MYSaSClerk
//
//  Created by chong on 2019/11/16.
//  Copyright © 2019 chong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@class HYUkBaseListViewController;

@protocol BaseListDelegate <NSObject>

- (void)HYUkBaseListViewController:(HYUkBaseListViewController *)viewController event:(id)event;

@end

@interface HYUkBaseListViewController : UIViewController <JXCategoryListContentViewDelegate>

@property (nonatomic, strong) id data;///<数据源.
@property (nonatomic, weak) id<BaseListDelegate> delegate;

//@property (nonatomic, strong) UICollectionView *collectionView;

- (void)initData;
- (void)initSubviews;

//请求网络数据
- (void)requestData;
//下拉刷新
- (void)refreshData;
//上拉加载
- (void)loadMoreData;

@end

NS_ASSUME_NONNULL_END
