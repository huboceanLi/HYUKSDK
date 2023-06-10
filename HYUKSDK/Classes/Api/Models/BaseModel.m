//
//  BaseModel.m
//  MYSaSClerk
//
//  Created by chong on 2019/11/16.
//  Copyright © 2019 chong. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>
//#import <YYKit/YYKit.h>
#import <YYModel/YYModel.h>

@implementation BaseModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化为-9999，如果取到此状态码说明模型转换不成功，即请求接口不是baseModel版本
        self.code = -9999;
    }
    return self;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"message":@"msg"};
}

@end

@implementation CommonBaseModel

- (id)copyWithZone:(NSZone *)zone{
    CommonBaseModel * baseModel = [[[self class] allocWithZone:zone] init];
    
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //通过property_getName函数获得属性的名字
        NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [baseModel setValue:[self valueForKey:propertyName] forKey:propertyName];
    }
    
    //立即释放properties指向的内存
    free(properties);

    return baseModel;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    
    CommonBaseModel * baseModel = [[[self class] allocWithZone:zone] init];
    
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //通过property_getName函数获得属性的名字
        NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [baseModel setValue:[self valueForKey:propertyName] forKey:propertyName];
    }
    
    //立即释放properties指向的内存
    free(properties);
    
    return baseModel;
}

#pragma mark-- <NSCoding>
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
