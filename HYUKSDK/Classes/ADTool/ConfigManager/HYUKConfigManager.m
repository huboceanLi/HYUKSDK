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

//- (void)getADData
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"configad" ofType:@"json"];
//    NSString *d = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//
//    self.ADIDModel = [HYUkADIDModel yy_modelWithJSON:d];
//}

@end
