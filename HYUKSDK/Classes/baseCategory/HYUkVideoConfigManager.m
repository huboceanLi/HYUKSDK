//
//  HYUkVideoConfigManager.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

#import "HYUkVideoConfigManager.h"

static HYUkVideoConfigManager *manager = nil;

@implementation HYUkVideoConfigManager

+ (HYUkVideoConfigManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)setChangeOrientation:(BOOL)isOrientation
{
    if ([self.delegate respondsToSelector:@selector(changeOrientation:)]) {
        [self.delegate changeOrientation:isOrientation];
    }
}

- (NSString *)changeTimeWithDuration:(NSInteger)duration {
    
    if (duration > 0) {
        
        NSInteger hou = duration % (60 * 60 * 24) / 3600;
        NSInteger min = duration % (60 * 60 * 24) % 3600 / 60;
        NSInteger sec = duration % (60 * 60 * 24) % 3600 % 60;

        if (hou > 0) {
            return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hou,min,sec];
        }
        return [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    }

    return @"00:00";
}

- (void)changeScoreColor:(NSString *)scoreStr Label:(UILabel *)lab
{
    double s = [scoreStr doubleValue];
    if (s <= 0.0) {
        lab.text = @"";
    }else {
        if (s >= 8.0) {
            lab.textColor = [UIColor textColorFF4];
        }else {
            lab.textColor = [UIColor textColorFFD];
        }
    }
}

- (NSString *)getNowTimeTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return timeSp;

}

//- (BOOL)isOpenTheProxy
//{
//
//#ifdef DEBUG
//    return NO;
//#else
//        NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
//        NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
//
//        NSDictionary *settings = proxies[0];
//
//        if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]) {
//            return NO;
//        } else {
//            return YES;
//        }
//#endif
//}
- (BOOL)isOpenTheProxy
{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    
    NSDictionary *settings = proxies[0];
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]) {
        return NO;
    } else {
        return YES;
    }
}

/*
 自定义方法：获取缓存大小
 */
- (NSString *)getCacheSize{
    //获取文件管理器
    NSFileManager *fileM = [NSFileManager defaultManager];
    //获取缓存路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    //得到缓存文件列表
    NSArray *childPaths = [fileM subpathsAtPath:cachePath];
    
    //存储文件总长度
    long long size = 0;
    for(NSString *childPath in childPaths){
        //得到文件路径
        NSString *filePath = [cachePath stringByAppendingPathComponent:childPath];
        
        //获取当前是文件还是目录
        BOOL isDir = NO;
        [fileM fileExistsAtPath:filePath isDirectory:&isDir];
 
        if(isDir){//如果是目录则跳出此次循环
            continue;
        }
        
        //将文件大小累加
        size = size + [[fileM attributesOfItemAtPath:filePath error:nil][NSFileSize] longLongValue];
    }

    return [self convertFileSize:size];
}

- (NSString *)convertFileSize:(long long)size {
    long kb = 1024;
    long mb = kb * 1024;
    long gb = mb * 1024;
    
    if (size >= gb) {
        return [NSString stringWithFormat:@"%.1f GB", (float) size / gb];
    } else if (size >= mb) {
        float f = (float) size / mb;
        if (f > 100) {
            return [NSString stringWithFormat:@"%.0f MB", f];
        }else{
            return [NSString stringWithFormat:@"%.1f MB", f];
        }
    } else if (size >= kb) {
        float f = (float) size / kb;
        if (f > 100) {
            return [NSString stringWithFormat:@"%.0f KB", f];
        }else{
            return [NSString stringWithFormat:@"%.1f KB", f];
        }
    } else
        return [NSString stringWithFormat:@"%lld B", size];
}

/*
 自定义方法，清除APP缓存
 */
- (void)clearCache{
    //获取文件管理器
    NSFileManager *fileM = [NSFileManager defaultManager];
    //获取缓存路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //清除缓存
    [fileM removeItemAtPath:cachePath error:nil];
}



@end
