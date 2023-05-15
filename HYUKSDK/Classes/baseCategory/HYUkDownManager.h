//
//  HYUkDownManager.h
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUkDownManager : NSObject

+ (HYUkDownManager *)sharedInstance;

- (void)startNetworkMonitoring;

@end

NS_ASSUME_NONNULL_END
