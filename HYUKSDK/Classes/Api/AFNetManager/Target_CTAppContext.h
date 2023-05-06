//
//  Target_CTAppContext.h
//  FaceStore
//
//  Created by 王博 on 2019/3/5.
//  Copyright © 2019年 cdhnf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_CTAppContext : NSObject

- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params;
- (BOOL)Action_isReachable:(NSDictionary *)params;
- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
