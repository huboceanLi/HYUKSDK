//
//  GCDGroup.h
//  GCDDemo
//
//  Created by cc on 2017/5/10.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDGroup : NSObject

@property(nonnull,strong,readonly) dispatch_group_t dispatchGroup;

#pragma mark-- 初始化
- (instancetype)init;

#pragma mark-- 用法
- (void)enter;
- (void)leave;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end
