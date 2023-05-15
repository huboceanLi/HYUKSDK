//
//  MYDialogViewController.h
//  OrderMeals
//
//  Created by chong on 2020/4/11.
//  Copyright © 2020 chong. All rights reserved.
//

#import "QMUIDialogViewController.h"
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYDialogViewController : QMUIDialogViewController

- (instancetype)initWithTitle:(NSString * _Nullable)title tipsString:(NSString *)tipsString;

@property(nonatomic, strong) UIView * customView;
@property(nonatomic, strong) UILabel * titleLabel;
@property(nonatomic, strong) UILabel * tipsLabel;

@end

NS_ASSUME_NONNULL_END
