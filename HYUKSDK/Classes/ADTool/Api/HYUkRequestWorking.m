//
//  HYUkRequestWorking.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/18.
//

#import "HYUkRequestWorking.h"
#import <YYModel/YYModel.h>
#import "APIString.h"

@implementation HYUkRequestWorking

+ (id)getVersionCompletionHandle:(void(^)(HYVideoVersionModel *model, BOOL success))completed
{
    
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    
    NSDictionary *dic = @{@"bundleid":bundleId};
    return [self GET:@"http://vod.wxspb.cn/api/index/get_version" parameters:dic complationHandle:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            
            HYVideoVersionBaseModel *model = [HYVideoVersionBaseModel yy_modelWithDictionary:responseObject];
            completed(model.data, YES);
        }else {
            completed(nil, NO);
        }
    }];
}

+ (id)getNoticeWithListMaXTime:(NSInteger)time success:(void(^)(NSArray <HYUKResponseNoticeItemModel *>*models, BOOL success))completed
{
    
    NSDictionary *dic = @{@"created_time":@(time)};

    return [self GET:video_get_notice parameters:dic complationHandle:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            
            HYUKResponseNoticeModel *model = [HYUKResponseNoticeModel yy_modelWithDictionary:responseObject];
            completed(model.data, YES);
        }else {
            completed(nil, NO);
        }
    }];
}

@end
