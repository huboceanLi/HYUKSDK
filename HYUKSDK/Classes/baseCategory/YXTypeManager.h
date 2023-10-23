//
//  YXTypeManager.h
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/10/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FromWayType) {
    FromWayType_Unknown = 0,       //
    FromWayType_home,    //
    FromWayType_detail_touch,    //
    FromWayType_detail_play,    //
    FromWayType_detail_gather,    //
    FromWayType_search,      //
    FromWayType_detail_banner,      //
};

@class YXTypeManager;

@protocol YXTypeManagerDelegate <NSObject>

@optional

- (void)showAdWithType:(FromWayType)type;


@end

@interface YXTypeManager : NSObject

+ (instancetype)shareInstance;

- (void)showAdWithType:(FromWayType)type complete:(void (^)(BOOL))complete;

//激励广告通过complete返值确定是否奖励， 其他类型全部返回yes
- (void)showAdWithResult:(BOOL)complete;

@property (nonatomic, weak) id <YXTypeManagerDelegate> delegate;

- (void)saveADKey:(NSString *)key;

- (BOOL)getADKey;

- (void)showBannerAdComplete:(void (^)(BOOL, UIView *))complete;

- (void)showBannerAdWithResult:(BOOL)complete adView:(UIView *)adView;

@end

NS_ASSUME_NONNULL_END
