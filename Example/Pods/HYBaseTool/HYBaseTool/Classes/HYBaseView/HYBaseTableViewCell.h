//
//  HYBaseTableViewCell.h
//  AmyNew
//
//  Created by chong on 2018/12/17.
//  Copyright © 2018 chong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYBaseTableViewCell;


@protocol BaseCellDelegate <NSObject>

@optional

/**
 *  CustomCell's event.
 *
 *  @param cell  CustomCell type class.
 *  @param event Event data.
 */
- (void)customCell:(HYBaseTableViewCell *)cell event:(id)event;

@end

@interface HYBaseTableViewCell : UITableViewCell

/**
 *  HYBaseTableViewCell's delegate.
 */
@property (nonatomic, weak) id <BaseCellDelegate> delegate;

/**
 *  CustomCell's data.
 */
@property (nonatomic, weak) id data;

/**
 *  CustomCell's indexPath.
 */
@property (nonatomic, weak) NSIndexPath *indexPath;

#pragma mark - Method you should overwrite.
- (void)initTableViewCell;

/**
 *  Load content, overwrite by subclass.
 */
- (void)loadContent;

/**
 *  Calculate the cell's height from data, overwrite by subclass.
 *
 *  @param data Data.
 *
 *  @return Cell's height.
 */
+ (CGFloat)cellHeightWithData:(id)data;

@end


