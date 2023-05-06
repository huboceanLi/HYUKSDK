//
//  HYVideoSingle.m
//  HYUKApiSdk_Example
//
//  Created by oceanMAC on 2023/5/6.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import "HYVideoSingle.h"
#import "APIString.h"

static HYVideoSingle *single = nil;

@implementation HYVideoSingle

+ (HYVideoSingle *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init];
    });
    return single;
}

- (void)categeryWithListSuccess:(RequestSuccessed)success fail:(RequestFailure)fail
{
    [APIBaseManager getLoadDataWithAPI:categary_list params:nil modelName:@"HYResponseCategeryModel" success:^(NSString *message, id responseObject) {
        if (success) {
            success(message, responseObject);
        }
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        if (fail) {
            fail(errorType, errorMessage);
        }
    }];
}

- (void)homeRecommendWithListSuccess:(RequestSuccessed)success fail:(RequestFailure)fail
{
    [APIBaseManager getLoadDataWithAPI:home_recommend params:nil modelName:@"HYResponseRecommendModel" success:^(NSString *message, id responseObject) {
        if (success) {
            success(message, responseObject);
        }
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        if (fail) {
            fail(errorType, errorMessage);
        }
    }];
}

- (void)getVideoDetaildID:(NSInteger)vid success:(RequestSuccessed)success fail:(RequestFailure)fail
{
    [APIBaseManager getLoadDataWithAPI:video_detail params:@{@"id":@(vid)} modelName:@"HYUkVideoDetailModel" success:^(NSString *message, id responseObject) {
        if (success) {
            success(message, responseObject);
        }
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        if (fail) {
            fail(errorType, errorMessage);
        }
    }];
}

- (void)getVideoListWithPage:(NSInteger)page type_id_1:(NSInteger)type_id_1 vod_area:(NSString *)vod_area vod_lang:(NSString *)vod_lang vod_year:(NSString *)vod_year order:(NSString *)order success:(RequestSuccessed)success fail:(RequestFailure)fail
{
    NSDictionary *dic = @{@"page":@(page),@"type_id_1":@(type_id_1),@"vod_area":vod_area,@"vod_lang":vod_lang,@"vod_year":vod_year,@"order":order};
    
    [APIBaseManager getLoadDataWithAPI:video_list params:dic modelName:@"HYResponseVideoListModel" success:^(NSString *message, id responseObject) {
        if (success) {
            success(message, responseObject);
        }
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        if (fail) {
            fail(errorType, errorMessage);
        }
    }];
}

@end