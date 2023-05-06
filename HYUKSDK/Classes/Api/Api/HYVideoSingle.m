//
//  HYVideoSingle.m
//  HYUKApiSdk_Example
//
//  Created by oceanMAC on 2023/5/6.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import "HYVideoSingle.h"
#import "APIString.h"

static HYVideoSingle *single = nil;

@implementation HYVideoSingle

+ (HYVideoSingle *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init];
    });
    return single;
}

- (void)categeryWithListSuccess:(RequestSuccessed)success fail:(RequestFailure)fail
{
    [APIBaseManager getLoadDataWithAPI:categary_list params:nil modelName:@"HYResponseCategeryModel" success:^(NSString *message, id responseObject) {
        if (success) {
            success(message, responseObject);
        }
    } fail:^(CTAPIManagerErrorType errorType, NSString *errorMessage) {
        if (fail) {
            fail(errorType, errorMessage);
        }
    }];
}

@end
