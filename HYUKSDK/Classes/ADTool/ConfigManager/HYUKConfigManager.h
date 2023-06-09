//
//  HYUKConfigManager.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/19.
//

#import <Foundation/Foundation.h>
#import "HYVideoVersionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUKConfigManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong) UIImage *linkImage;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, assign) CGRect linkRect;
@property (nonatomic) HYVideoVersionModel *versionModel;

//- (void)getADData;

@end

NS_ASSUME_NONNULL_END
