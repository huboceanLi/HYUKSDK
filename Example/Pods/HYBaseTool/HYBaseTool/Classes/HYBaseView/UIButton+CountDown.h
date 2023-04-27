//
//  UIButton+CountDown.h
//  MYSaSClerk
//
//  Created by chong on 2019/11/18.
//  Copyright © 2019 chong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CountDown)

/**
 倒计时
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

/**
 * 停止倒计时
 */
- (void)stopTimeWithTitle:(NSString *)title color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
