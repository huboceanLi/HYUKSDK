//
//  HYUkShowLoadingManager.h
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUkShowLoadingManager : NSObject

+ (HYUkShowLoadingManager *)sharedInstance;

- (void)showLoading:(UIView *)baseView;

- (void)removeLoading;

@end

NS_ASSUME_NONNULL_END
