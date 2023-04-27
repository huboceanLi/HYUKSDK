//
//  BaseListViewController.m
//  MYSaSClerk
//
//  Created by chong on 2019/11/16.
//  Copyright © 2019 chong. All rights reserved.
//

#import "BaseListViewController.h"

@interface BaseListViewController ()

@end

@implementation BaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initSubviews];
    [self requestData];
}

- (void)initData
{}

- (void)initSubviews
{}

- (void)requestData {}

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
