//
//  UITableView+EmptyView.m
//  MYSaSClerk
//
//  Created by chong on 2019/11/16.
//  Copyright © 2019 chong. All rights reserved.
//

#import "UITableView+EmptyView.h"
#import <objc/runtime.h>
#import "HYUkHeader.h"

static char UITableViewRealEmptyView;

@implementation UITableView (EmptyView)
@dynamic emptyView;

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method reloadData    = class_getInstanceMethod(self, @selector(reloadData));
        Method xy_reloadData = class_getInstanceMethod(self, @selector(am_reloadData));
        method_exchangeImplementations(reloadData, xy_reloadData);
        
        Method oldInit = class_getInstanceMethod(self, @selector(initWithFrame:style:));
        Method myInit = class_getInstanceMethod(self, @selector(my_initWithFrame:style:));
        method_exchangeImplementations(oldInit, myInit);
    });
}

- (instancetype)my_initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    id object = [self my_initWithFrame:frame style:style];
    if (object) {
        self.separatorColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    }
    return object;
}

- (void)am_reloadData
{
    [self am_reloadData];
    
    //  忽略第一次加载
    if (![self isInitFinish]) {
        [self hideEmptyView];
        [self setIsInitFinish:YES];
        return ;
    }
    //  刷新完成之后检测数据量
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSInteger numberOfSections = [self numberOfSections];
        BOOL havingData = NO;
        for (NSInteger i = 0; i < numberOfSections; i++) {
            if ([self numberOfRowsInSection:i] > 0) {
                havingData = YES;
                break;
            }
        }
        
        if (havingData) {
            [self hideEmptyView];
        } else {
            [self showEmptView];
        }
    });
}

#pragma mark - 属性

/**
 设置已经加载完成数据了
 */
- (void)setIsInitFinish:(BOOL)finish {
    objc_setAssociatedObject(self, @selector(isInitFinish), @(finish), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 是否已经加载完成数据
 */
- (BOOL)isInitFinish {
    id obj = objc_getAssociatedObject(self, _cmd);
    return [obj boolValue];
}

- (QMUIEmptyView *)emptyView
{
    return objc_getAssociatedObject(self, &UITableViewRealEmptyView);
}

- (void)setEmptyView:(QMUIEmptyView *)emptyView
{
    [self willChangeValueForKey:@"emptyView"];
    objc_setAssociatedObject(self, &UITableViewRealEmptyView,
                             emptyView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"emptyView"];
}


- (void)showEmptView
{
    self.emptyView.hidden = NO;
}

- (void)updateEmptyViewWithImageName:(NSString *)imageName title:(NSString *)title
{
    if (!self.emptyView) {
        self.emptyView = [[QMUIEmptyView alloc] init];
        [self.emptyView setLoadingViewHidden:YES];
        
        [self insertSubview:self.emptyView atIndex:0];
        
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self);
        }];
    }
    if (imageName.length > 0) {
        [self.emptyView setImage:[UIImage uk_bundleImage:imageName]];
    }
    [self.emptyView setTextLabelText:title];
    self.emptyView.textLabelInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self.emptyView setTextLabelFont:[UIFont systemFontOfSize:18.0 weight:UIFontWeightMedium]];
    [self.emptyView setTextLabelTextColor: [[UIColor blackColor] colorWithAlphaComponent:0.5]];
}


- (void)hideEmptyView {
    if (self.emptyView) {
        self.emptyView.hidden = YES;
    }
}

@end
