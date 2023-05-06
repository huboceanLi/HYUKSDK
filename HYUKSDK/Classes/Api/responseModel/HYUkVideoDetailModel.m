//
//  HYUkVideoDetailModel.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

#import "HYUkVideoDetailModel.h"

@implementation HYUkVideoDetailModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"vod_play_url" : [HYUkVideoDetailItemModel class]};
}

@end


@implementation HYUkVideoDetailItemModel

@end
