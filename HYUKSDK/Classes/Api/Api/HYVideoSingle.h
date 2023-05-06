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

- (void)getVideoDetaildID:(NSInteger)vid success:(RequestSuccessed)success fail:(RequestFailure)fail;

- (void)getVideoListWithPage:(NSInteger)page type_id_1:(NSInteger)type_id_1 vod_area:(NSString *)vod_area vod_lang:(NSString *)vod_lang vod_year:(NSString *)vod_year order:(NSString *)order success:(RequestSuccessed)success fail:(RequestFailure)fail;

@end

NS_ASSUME_NONNULL_END
