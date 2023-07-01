//
//  HYUKConfigManager.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/19.
//

#import "HYUKConfigManager.h"
#import <YYModel/YYModel.h>

static HYUKConfigManager * configManager = nil;

@implementation HYUKConfigManager

+(HYUKConfigManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager = [[HYUKConfigManager alloc] init];
    });
    return configManager;
}


@end
