//
//  UICollectionView+EmptyView.h.m
//  OrderMeals
//
//  Created by chong on 2020/4/16.
//  Copyright © 2020 chong. All rights reserved.
//

#import "UICollectionView+UKEmptyView.h"
#import <objc/runtime.h>
#import "HYUkHeader.h"

static char UICollectionRealEmptyView;

@implementation UICollectionView (UKEmptyView)

@dynamic emptyView;

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method reloadData    = class_getInstanceMethod(self, @selector(reloadData));
        Method xy_reloadData = class_getInstanceMethod(self, @selector(uk_reloadData));
        method_exchangeImplementations(reloadData, xy_reloadData);
    });
}

- (void)uk_reloadData
{
    [self uk_reloadData];
    
    //  忽略第一次加载
    if (![self isUkInitFinish]) {
        [self hideEmptyView];
        [self setIsUkInitFinish:YES];
        return ;
    }
    //  刷新完成之后检测数据量
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSInteger numberOfSections = [self numberOfSections];
        BOOL havingData = NO;
        for (NSInteger i = 0; i < numberOfSections; i++) {
            if ([self numberOfItemsInSection:i] > 0) {
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
- (void)setIsUkInitFinish:(BOOL)finish {
    objc_setAssociatedObject(self, @selector(isUkInitFinish), @(finish), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 是否已经加载完成数据
 */
- (BOOL)isUkInitFinish {
    id obj = objc_getAssociatedObject(self, _cmd);
    return [obj boolValue];
}

- (QMUIEmptyView *)emptyView
{
    return objc_getAssociatedObject(self, &UICollectionRealEmptyView);
}

- (void)setEmptyView:(QMUIEmptyView *)emptyView
{
    [self willChangeValueForKey:@"emptyView"];
    objc_setAssociatedObject(self, &UICollectionRealEmptyView,
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
    self.emptyView.textLabelInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self.emptyView setImage:[UIImage uk_bundleImage:imageName]];
    [self.emptyView setTextLabelText:title];
    [self.emptyView setTextLabelFont:[UIFont systemFontOfSize:18.0 weight:UIFontWeightMedium]];
    [self.emptyView setTextLabelTextColor: [[UIColor blackColor] colorWithAlphaComponent:0.5]];
}

- (void)setEmptyViewWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail
{
    if (!self.emptyView) {
        self.emptyView = [[QMUIEmptyView alloc] init];
        [self.emptyView setLoadingViewHidden:YES];
        
        [self insertSubview:self.emptyView atIndex:0];
        
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self);
        }];
    }
    
    [self.emptyView setImage:[UIImage uk_bundleImage:imageName]];
    [self.emptyView setTextLabelText:title];
    [self.emptyView setTextLabelFont:[UIFont systemFontOfSize:18.0 weight:UIFontWeightMedium]];
    [self.emptyView setTextLabelTextColor: [[UIColor blackColor] colorWithAlphaComponent:0.6]];
    
    [self.emptyView setDetailTextLabelText:detail];
    [self.emptyView setDetailTextLabelFont:[UIFont systemFontOfSize:15.0]];
    [self.emptyView setDetailTextLabelTextColor:[UIColor lightGrayColor]];
}

- (void)updateEmptyViewWithImageName:(NSString *)imageName text:(NSString *)text buttonTitle:(NSString *)buttonTitle {
    if (!self.emptyView) {
        self.emptyView = [[QMUIEmptyView alloc] init];
        [self.emptyView setLoadingViewHidden:YES];
        
        [self insertSubview:self.emptyView atIndex:0];
        
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self);
        }];
        
        self.emptyView.textLabelInsets = UIEdgeInsetsMake(-30, 0, 10, 0);
    }
    
    [self.emptyView setImage:[UIImage uk_bundleImage:imageName]];
    [self.emptyView setTextLabelText:text];
    [self.emptyView setActionButtonTitle:buttonTitle];
    
    self.emptyView.actionButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    UIColor *color = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.emptyView.actionButton.layer.backgroundColor = color.CGColor;
    self.emptyView.actionButtonFont = UIFontMake(15);
    self.emptyView.actionButton.layer.cornerRadius = 19;
}


- (void)hideEmptyView {
    if (self.emptyView) {
        self.emptyView.hidden = YES;
    }
}

@end
