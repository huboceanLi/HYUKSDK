//
//  HYBaseCollectionViewCell.h
//  AmyNew
//
//  Created by chong on 2018/12/14.
//  Copyright © 2018 chong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYBaseCollectionViewCell;
NS_ASSUME_NONNULL_BEGIN

@protocol BaseCollectionCellDelegate <NSObject>

@optional

/**
 *  CustomCollectionCell's event.
 *
 *  @param cell  CustomCollectionCell
 *  @param event Event.
 */
- (void)customCollectionCell:(HYBaseCollectionViewCell *)cell event:(id)event;

@end

@interface HYBaseCollectionViewCell : UICollectionViewCell

/**
 *  HYBaseCollectionViewCell's delegate.
 */
@property (nonatomic, weak) id <BaseCollectionCellDelegate> delegate;
/**
 *  BaseCell's data.
 */
@property (nonatomic, weak) id data;

/**
 *  BaseCell's indexPath.
 */
@property (nonatomic, weak) NSIndexPath *indexPath;

#pragma mark - Method you should overwrite.
- (void)initSubViews;

/**
 *  Load content, override by subclass.
 */
- (void)loadContent;

@end

NS_ASSUME_NONNULL_END
