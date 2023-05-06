//
//  Target_FaceStoreService.m
//  FaceStore
//
//  Created by 王博 on 2019/3/5.
//  Copyright © 2019年 cdhnf. All rights reserved.
//

#import "Target_FaceStoreService.h"

NSString * const FaceStoreServiceIdentifier = @"FaceStoreService";

@implementation Target_FaceStoreService

- (FaceStoreService *)Action_FaceStoreService:(NSDictionary *)params
{
    return [[FaceStoreService alloc] init];
}
@end
