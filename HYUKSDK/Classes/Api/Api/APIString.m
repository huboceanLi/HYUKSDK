//
//  APIString.m
//  lincao
//
//  Created by lihaiyang on 2021/1/11.
//

#import "APIString.h"

@implementation APIString

#pragma mark-- BaseString

#if 1
//开发
NSString *const Service_URL = @"http://vod.wxspb.cn";
//NSString *const Service_URL = @"http://192.168.96.31:8075";

#elif 0
//生产
//NSString *const Service_URL = @"https://xs.meiy365.com";
NSString *const Service_URL = @"http://vod.wxspb.cn";

#endif

NSString * const Api = @"/api/movies";

#pragma mark - cache key
NSString * const categary_list = @"get_type";
NSString * const home_recommend = @"recommend";
NSString * const video_detail = @"get_detail";
NSString * const video_list = @"get_list";
NSString * const video_search = @"search_movies";
NSString * const video_rank = @"get_rank";
NSString * const video_guess_Like = @"guess_you_like";

NSString * const video_get_version = @"http://vod.wxspb.cn/api/index/get_version";

#pragma mark-- config
NSString * const video_allow_flow_play = @"video_allow_flow_play";
NSString * const net_change_wan = @"net_change_wan";
NSString * const supper_user = @"SUPPERUSER";

@end
