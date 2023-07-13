//
//  HYUkRequestWorking.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/18.
//
#import <Foundation/Foundation.h>
#import "HYUKBaseRequset.h"
#import "HYVideoVersionModel.h"
#import "HYUKResponseNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUkRequestWorking : HYUKBaseRequset


+ (id)getVersionCompletionHandle:(void(^)(HYVideoVersionModel *model, BOOL success))completed;

+ (id)getNoticeWithListMaXTime:(NSInteger)time success:(void(^)(NSArray <HYUKResponseNoticeItemModel *>*models, BOOL success))completed;

+ (id)isSaleInStoreWithSuccess:(void (^)(BOOL success))success;

@end

NS_ASSUME_NONNULL_END
