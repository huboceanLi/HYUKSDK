//
//  HYUkConfigManager.h
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

#import <Foundation/Foundation.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUkConfigManager : NSObject

+ (HYUkConfigManager *)sharedInstance;

- (void)changeScoreColor:(NSString *)scoreStr Label:(UILabel *)lab;

@end

NS_ASSUME_NONNULL_END
