//
//  MYToast.h
//  MYERP
//
//  Created by chong on 2020/3/13.
//  Copyright © 2020 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYToast : NSObject

+ (void)showWithText:(nullable NSString *)text;
+ (void)showWithText:(nullable NSString *)text inView:(UIView *)view;
+ (void)showWithText:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
