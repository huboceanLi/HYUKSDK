//
//  GCDTimer.h
//  GCDDemo
//
//  Created by cc on 2017/5/12.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCDQueue;

@interface GCD_Timer : NSObject

@property (strong,readonly,nonatomic) dispatch_source_t dispatchSource;

#pragma mark--初始化
- (instancetype)init;
- (instancetype)initInQueue:(GCDQueue *)queue;

#pragma mark-用法

- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval;
- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval delay:(uint64_t)delay;
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs;
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs;
- (void)start;
- (void)destroy;
@end
