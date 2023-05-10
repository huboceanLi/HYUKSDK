//
//  HYUkConfigManager.h
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

#import <Foundation/Foundation.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN


@protocol HYUkVideoInitDelegate <NSObject>

@optional

- (void)changeOrientation:(BOOL)isOrientation;

@end

@interface HYUkConfigManager : NSObject

+ (HYUkConfigManager *)sharedInstance;

- (void)changeScoreColor:(NSString *)scoreStr Label:(UILabel *)lab;

- (NSString *)getNowTimeTimestamp;

- (void)setChangeOrientation:(BOOL)isOrientation;

@property (nonatomic, weak) id <HYUkVideoInitDelegate> delegate;

- (NSString *)changeTimeWithDuration:(NSInteger)duration;

@end

NS_ASSUME_NONNULL_END
