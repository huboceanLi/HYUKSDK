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


@end
