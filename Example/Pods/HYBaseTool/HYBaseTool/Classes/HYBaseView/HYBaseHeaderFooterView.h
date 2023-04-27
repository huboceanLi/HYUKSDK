//
//  HYBaseHeaderFooterView.h
//  AmyNew
//
//  Created by chong on 2018/12/21.
//  Copyright © 2018 chong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYBaseHeaderFooterView;


@protocol HYBaseHeaderFooterViewDelegate <NSObject>

@optional

/**
 *  CustomHeaderFooterView's event.
 *
 *  @param customHeaderFooterView CustomHeaderFooterView object.
 *  @param event                  Event data.
 */
- (void)HYBaseHeaderFooterView:(HYBaseHeaderFooterView *)customHeaderFooterView event:(id)event;

@end

@interface HYBaseHeaderFooterView : UITableViewHeaderFooterView

/**
 *  CustomHeaderFooterView's delegate.
 */
@property (nonatomic, weak) id <HYBaseHeaderFooterViewDelegate> delegate;

/**
 *  CustomHeaderFooterView's data.
 */
@property (nonatomic, weak) id data;

/**
 *  UITableView's section.
 */
@property (nonatomic) NSInteger section;

#pragma mark - Some useful method.

/**
 *  Set HeaderFooterView backgroundColor.
 *
 *  @param color Color.
 */
- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color;

#pragma mark - Method override by subclass.

/**
 *  Setup HeaderFooterView, override by subclass.
 */
- (void)setupHeaderFooterView;

/**
 *  Build subview, override by subclass.
 */
- (void)buildSubview;

/**
 *  Load content, override by subclass.
 */
- (void)loadContent;

/**
 *  Calculate the cell's from data, overwrite by subclass.
 *
 *  @param data Data.
 *
 *  @return HeaderFooterView's height.
 */
+ (CGFloat)heightWithData:(id)data;

@end


