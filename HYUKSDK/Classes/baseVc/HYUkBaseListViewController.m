//
//  HYUkBaseListViewController.m
//  MYSaSClerk
//
//  Created by chong on 2019/11/16.
//  Copyright © 2019 chong. All rights reserved.
//

#import "HYUkBaseListViewController.h"
#import "HYUkHeader.h"

@interface HYUkBaseListViewController ()

@end

@implementation HYUkBaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initSubviews];
    [self requestData];
    
}

- (void)initData
{
}

- (void)initSubviews
{
}

- (void)requestData {
    [self.collectionView updateEmptyViewWithImageName:@"uk_nodata" title:@"暂无数据"];
}

- (void)refreshData {}

- (void)loadMoreData {}

#pragma mark--<JXCategoryListContentViewDelegate>
- (UIView *)listView
{
    return self.view;
}

- (void)listDidAppear
{}

- (void)listDidDisappear
{}

@end
