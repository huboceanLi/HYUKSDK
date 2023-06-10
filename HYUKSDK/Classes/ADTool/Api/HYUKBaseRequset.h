//
//  HYUKBaseRequset.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/18.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUKBaseRequset : NSObject

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params complationHandle:(void(^)(id responseObject, NSError *error))completed;

/** 对AFHTTPSessionManager的POST请求方法进行了封装 */
+ (id)POST:(NSString *)path parameters:(NSDictionary *)params complationHandle:(void(^)(id responseObject, NSError *error))completed;

@end

NS_ASSUME_NONNULL_END
