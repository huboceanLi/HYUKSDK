//
//  HYResponseCategeryModel.m
//  HYUKSDK_Example
//
//  Created by oceanMAC on 2023/4/28.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import "HYResponseCategeryModel.h"

@implementation HYResponseCategeryModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"type" : [HYResponseCategeryTypeModel class]};
}

@end

@implementation HYResponseCategeryTypeModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end
