//
//  HYUKInitTool.h
//  HYUKADSDK
//
//  Created by oceanMAC on 2023/5/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUKInitTool : NSObject

+ (void)initTool:(UIImage *)linkImage icon:(UIImage *)icon linkRect:(CGRect)rect window:(UIWindow *)window enter:(void (^)(BOOL pt))enter;

@end

NS_ASSUME_NONNULL_END
