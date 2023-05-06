//
//  HYVideoSingle.h
//  HYUKApiSdk_Example
//
//  Created by oceanMAC on 2023/5/6.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYVideoSingle : NSObject

+ (HYVideoSingle *)sharedInstance;

#pragma mark--categary
- (void)categeryWithListSuccess:(RequestSuccessed)success fail:(RequestFailure)fail;

- (void)homeRecommendWithListSuccess:(RequestSuccessed)success fail:(RequestFailure)fail;

@end

NS_ASSUME_NONNULL_END
