//
//  PopViewController.h
//  MYSaSClerk
//
//  Created by chong on 2019/11/30.
//  Copyright © 2019 chong. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "QMUIModalPresentationViewController.h"
#import <Masonry/Masonry.h>

@class PopViewController;

@protocol PopViewControllerDelegate <NSObject>

/**
 选择弹框内容

 @param popVC PopViewController
 @param event event
 */
- (void)popViewController:(PopViewController *)popVC event:(id)event;

@end

/**
 * 弹框ViewController
 */
@interface PopViewController : QMUIModalPresentationViewController

@property (nonatomic, strong) id data;
@property (nonatomic, weak) id<PopViewControllerDelegate> popVCDelegate;

- (void)initData;

- (void)initSubViews;

- (void)loadContent;


@end


