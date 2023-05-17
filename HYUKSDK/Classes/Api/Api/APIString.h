//
//  APIString.h
//  lincao
//
//  Created by lihaiyang on 2021/1/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface APIString : NSObject

#pragma mark-- BaseString
extern NSString * const Service_URL;
extern NSString * const Api;


extern NSString * const categary_list;

extern NSString * const home_recommend;

extern NSString * const video_detail;

extern NSString * const video_list;

extern NSString * const video_search;

extern NSString * const video_rank;

extern NSString * const video_guess_Like;

#pragma mark-- config
extern NSString * const video_allow_flow_play;
extern NSString * const net_change_wan;


@end

NS_ASSUME_NONNULL_END
