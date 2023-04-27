//
//  UserDefault.h
//  FaceStore
//
//  Created by cdhnf on 2019/3/26.
//  Copyright © 2019年 cdhnf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 封装NSUserDefault的 添加数据方法 和 删除数据方法
 */
@interface UserDefault : NSObject

/**
 取NSInteger数据

 @param key key description
 @return return value description
 */
+ (NSInteger)integerValueForKey:(NSString *)key;

/**
 取NSString数据

 @param key key description
 @return return value description
 */
+ (NSString*)stringValueForKey:(NSString*)key;

/**
 取字典数据

 @param key key description
 @return return value description
 */
+ (NSDictionary*)dicValueForKey:(NSString*)key;

/**
 取float数据

 @param key key description
 @return return value description
 */
+ (CGFloat)floatValueForKey:(NSString*)key;

/**
 取BOOL数据

 @param key key description
 @return return value description
 */
+ (BOOL)boolValueForKey:(NSString*)key;

/**
 取NSObject数据

 @param key key
 @return NSObject
 */
+ (id)objectValueForKey:(NSString *)key;

/**
 取数组数据

 @param key key description
 @return NSArray
 */
+ (NSArray<NSString *> *)arrayValueForKey:(NSString *)key;

/**
 存NSInteger数据

 @param value value description
 @param key key description
 */
+ (void)setInteger:(NSInteger)value forKey:(NSString*)key;


/**
 存bool数据

 @param value value description
 @param key key description
 */
+ (void)setBool:(BOOL)value forKey:(NSString*)key;

/**
 存float数据

 @param value value description
 @param key key description
 */
+ (void)setFloat:(float)value forkey:(NSString*)key;

/**
 存string数据

 @param string string description
 @param key key description
 */
+ (void)setNSString:(NSString *)string forKey:(NSString *)key;

/**
 添加数据方法

 @param value value description
 @param key key description
 */
+ (void)setObject:(id)value forKey:(NSString *)key;

/**
 添加数组数据

 @param value value description
 @param key key description
 */
+ (void)addObject:(id)value forKey:(NSString *)key;

/**
 删除数据方法

 @param key key description
 */
+ (void)removeObjectForKey:(NSString *)key;

/**
 返回userDefault里面所有的Key值

 @return return value description
 */
+ (NSArray*)allKeys;

/**
 是否拥有 传入的Key值

 @param key key description
 */
+ (BOOL)hasKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
