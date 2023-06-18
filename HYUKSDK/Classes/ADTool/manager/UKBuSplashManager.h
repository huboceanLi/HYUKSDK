//
//  UKBuSplashManager.h
//  AFNetworking
//
//  Created by Ocean 李 on 2023/6/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UKBuSplashManager : NSObject

+(UKBuSplashManager *)shared;

@property (nonatomic, strong) NSString *recordID;
@property (nonatomic, strong) NSString *recordName;
@property (nonatomic, strong) UIImage *linkImage;

- (void)registerAppIdSuccess:(void (^)(BOOL initSuccess))initSuccess;

- (void)loadSplashAdWithVC:(UIViewController *)vc close:(void (^)(BOOL close))close;

@end

NS_ASSUME_NONNULL_END
