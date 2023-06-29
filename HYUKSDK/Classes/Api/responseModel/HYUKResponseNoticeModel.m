//
//  HYUKResponseNoticeModel.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/6/29.
//

#import "HYUKResponseNoticeModel.h"

@implementation HYUKResponseNoticeModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [HYUKResponseNoticeItemModel class]};
}

@end

@implementation HYUKResponseNoticeItemModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}


@end
