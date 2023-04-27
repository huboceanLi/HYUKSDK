//
//  UserDefault.m
//  FaceStore
//
//  Created by cdhnf on 2019/3/26.
//  Copyright © 2019年 cdhnf. All rights reserved.
//

#import "UserDefault.h"

@implementation UserDefault

+ (BOOL)boolValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}

+ (NSInteger)integerValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:key];
}

+ (NSString *)stringValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:key];
}

+ (NSDictionary *)dicValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults dictionaryForKey:key];
}

+ (CGFloat)floatValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults floatForKey:key];
}

+ (id)objectValueForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+ (NSArray<NSString *> *)arrayValueForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringArrayForKey:key];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:key];
    [userDefaults synchronize];
}

+ (void)setBool:(BOOL)value forKey:(NSString*)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}
+ (void)setFloat:(float)value forkey:(NSString*)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:value forKey:key];
    [userDefaults synchronize];
}

+ (void)setNSString:(NSString *)string forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:string forKey:key];
    [userDefaults synchronize];
}

+ (void)setObject:(id)value forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

+ (void)addObject:(id)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * array = [userDefaults objectForKey:key];
    
    NSMutableArray * mutableCopyArray = [array mutableCopy];
    if (!mutableCopyArray) {
        mutableCopyArray = [NSMutableArray array];
    }
    
    if ([mutableCopyArray containsObject:value]) {
        [mutableCopyArray removeObject:value];
    }
    
    [mutableCopyArray insertObject:value atIndex:0];
    [userDefaults setObject:mutableCopyArray forKey:key];
}

+ (void)removeObjectForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

+ (NSArray *)allKeys {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[userDefaults dictionaryRepresentation] allKeys];
}

+ (BOOL)hasKey:(NSString*)key {
    NSArray *allKeys = [self allKeys];
    NSInteger index = [allKeys indexOfObject:key];
    return index != NSNotFound;
}

@end
