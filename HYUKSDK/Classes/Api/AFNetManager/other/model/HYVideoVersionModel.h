//
//  HYVideoVersionModel.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HYVideoVersionBaseModel;

@interface HYVideoVersionModel : NSObject

@property (nonatomic, strong) NSString * bundleId;   ///bundleId
@property (nonatomic, strong) NSString * version;   ///version
@property (nonatomic, strong) NSString * url;   ///指定url
@property (nonatomic, strong) NSString * start_id;   ///开屏id
@property (nonatomic, strong) NSString * smallbannerid;   ///小bannerid
@property (nonatomic, strong) NSString * bigbannerid;   ///
@property (nonatomic, strong) NSString * incentive_adid;   ///激励id
@property (nonatomic, strong) NSString * content;   ///更新内容
@property (nonatomic, strong) NSString * status_text;   ///<提示信息
@property (nonatomic, assign) NSInteger adtype;   ///ad类型
@property (nonatomic, assign) BOOL open_ad;   ///开启广告:1=是,0=否
@property (nonatomic, assign) NSInteger force;   ///0=不更新,1=更新,2=强制更新

@end

@interface HYVideoVersionBaseModel : NSObject

@property (nonatomic, assign) NSInteger code;   ///
@property (nonatomic, strong) NSString * msg;   //
@property (nonatomic, strong) HYVideoVersionModel * data;   //

@end

NS_ASSUME_NONNULL_END
