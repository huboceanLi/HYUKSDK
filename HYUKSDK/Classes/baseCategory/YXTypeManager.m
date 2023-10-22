//
//  YXTypeManager.m
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/10/6.
//

#import "YXTypeManager.h"
//#import "YXDefine.h"

static YXTypeManager * configManager = nil;

@interface YXTypeManager ()

@property (copy, nonatomic) void (^complete)(BOOL);

@end

@implementation YXTypeManager

+(YXTypeManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager = [[YXTypeManager alloc] init];
    });
    return configManager;
}

- (void)showAdWithType:(FromWayType)type complete:(void (^)(BOOL))complete
{
    self.complete = [complete copy];

//    if ([YXDefine getADKey]) {
//        self.complete(YES);
//    }else {
        
        if (type == FromWayType_detail_touch) {
//            if ([YXDefine getADJLKey]) {
//                self.complete(YES);
//            }else {
                if ([self.delegate respondsToSelector:@selector(showAdWithType:)]) {
                    [self.delegate showAdWithType:type];
                }
//            }
        }else {
            if ([self.delegate respondsToSelector:@selector(showAdWithType:)]) {
                [self.delegate showAdWithType:type];
            }
        }
//    }
}

- (void)showAdWithResult:(BOOL)complete
{
    self.complete(complete);
}

@end
