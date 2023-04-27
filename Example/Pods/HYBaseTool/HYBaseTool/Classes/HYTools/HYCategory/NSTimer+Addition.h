//
//  NSTimer+Addition.h
//  CasualPay
//
//  Created by Angel_Yan on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

/**
 暂停
 */
- (void)pauseTimer;

/**
 继续
 */
- (void)resumeTimer;

/**
 一定时间后继续

 @param interval interval description
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
