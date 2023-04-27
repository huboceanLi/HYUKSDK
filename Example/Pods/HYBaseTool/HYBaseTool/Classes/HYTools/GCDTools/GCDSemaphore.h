//
//  GCDSemaphore.h
//  GCDDemo
//
//  Created by cc on 2017/5/12.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDSemaphore : NSObject

@property (nonatomic, readonly, strong) dispatch_semaphore_t dispatchSemaphore;

#pragma mark--初始化
- (instancetype)init;
- (instancetype)initWithValue:(long)value;

#pragma mark-- 用法
- (BOOL)signal;
- (void)wait;
- (BOOL)wait:(ino64_t)delta;

@end
