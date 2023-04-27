//
//  UITableView+EmptyView.h
//  MYSaSClerk
//
//  Created by chong on 2019/11/16.
//  Copyright © 2019 chong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (EmptyView)

@property (nonatomic, strong) QMUIEmptyView *emptyView;

-(void)hideEmptyView;

- (void)updateEmptyViewWithImageName:(NSString *)imageName title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
