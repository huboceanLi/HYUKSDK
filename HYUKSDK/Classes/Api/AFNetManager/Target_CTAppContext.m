//
//  Target_CTAppContext.m
//  FaceStore
//
//  Created by 王博 on 2019/3/5.
//  Copyright © 2019年 cdhnf. All rights reserved.
//

#import "Target_CTAppContext.h"

@implementation Target_CTAppContext

- (BOOL)Action_isReachable:(NSDictionary *)params
{
    return YES;
}

- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params
{
    return YES;
}

- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params
{
    return 2;
}

@end
