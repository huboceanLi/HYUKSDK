//
//  Target_FaceStoreService.h
//  FaceStore
//
//  Created by 王博 on 2019/3/5.
//  Copyright © 2019年 cdhnf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FaceStoreService.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const FaceStoreServiceIdentifier;

@interface Target_FaceStoreService : NSObject

- (FaceStoreService *)Action_FaceStoreService:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
