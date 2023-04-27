//
//  HYBaseView.h
//  AMStore
//
//  Created by chong on 2019/2/14.
//  Copyright © 2019 chong. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HYBaseView;

@protocol HYBaseViewDelegate <NSObject>

@optional

- (void)customView:(HYBaseView *)view event:(id)event;

@end

/*
 * 抽象View
 */
@interface HYBaseView : UIView

@property (nonatomic, weak) id <HYBaseViewDelegate> delegate;
@property (nonatomic, strong) id data;

- (void)initData;
- (void)initSubviews;

- (void)loadContent;

@end

