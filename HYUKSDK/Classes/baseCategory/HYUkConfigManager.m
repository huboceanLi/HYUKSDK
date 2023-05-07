//
//  HYUkConfigManager.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

#import "HYUkConfigManager.h"

static HYUkConfigManager *manager = nil;

@implementation HYUkConfigManager

+ (HYUkConfigManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
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

@end
