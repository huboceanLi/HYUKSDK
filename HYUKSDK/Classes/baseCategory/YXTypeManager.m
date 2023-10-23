//
//  YXTypeManager.m


#import "YXTypeManager.h"
//#import "YXDefine.h"

static YXTypeManager * configManager = nil;

@interface YXTypeManager ()

@property (copy, nonatomic) void (^complete)(BOOL);

@property (copy, nonatomic) void (^adComplete)(BOOL,UIView*);

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

    if ([self getADKey]) {
        self.complete(YES);
    }else {
        if ([self.delegate respondsToSelector:@selector(showAdWithType:)]) {
            [self.delegate showAdWithType:type];
        }
    }
}

- (void)saveADKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:key forKey:@"ADKEY"];
    [userDefaults synchronize];
}

- (BOOL)getADKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [userDefaults stringForKey:@"ADKEY"];
    if ([key isEqualToString:@"7235"]) {
        return YES;
    }
    return NO;
    
}

- (void)showAdWithResult:(BOOL)complete
{
    self.complete(complete);
}

- (void)showBannerAdComplete:(void (^)(BOOL, UIView *))complete
{
    self.adComplete = [complete copy];
    
    if ([self getADKey]) {
        self.adComplete(YES, nil);
    }else {
        if ([self.delegate respondsToSelector:@selector(showAdWithType:)]) {
            [self.delegate showAdWithType:FromWayType_detail_banner];
        }
    }
}

- (void)showBannerAdWithResult:(BOOL)complete adView:(UIView *)adView
{
    self.adComplete(complete, adView);
}

@end
