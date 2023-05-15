//
//  HYUkDownManager.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/15.
//

#import "HYUkDownManager.h"
#import "LHYReachability.h"

static HYUkDownManager *manager = nil;

@interface HYUkDownManager()

@property (nonatomic) LHYReachability *hostReachability;

@end

@implementation HYUkDownManager

+ (HYUkDownManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        
        manager.hostReachability = [LHYReachability reachabilityWithHostName:@"https://www.baidu.com"];
        [manager.hostReachability startNotifier];
    });
    return manager;
}

- (void)startNetworkMonitoring
{
    NetworkStatus netStatus = [self.hostReachability currentReachabilityStatus];
    switch (netStatus){
        case NotReachable: {
            NSLog(@"ViewController : 没有网络！");
            break;
        }
        case ReachableViaWWAN: {
            
            NSLog(@"ViewController : 4G/3G");
            break;
        }
        case ReachableViaWiFi: {
            
            NSLog(@"ViewController : WiFi");
            break;
        }
    }
}

@end
