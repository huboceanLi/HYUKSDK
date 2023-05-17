//
//  HYUkDownManager.h
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, HYUkDownStatus) {
    down_wait = 0,       //
    downing ,    //
    down_pause,      //
    down_success,
};

@class HYUkDownListModel;

@protocol HYUkDownManagerDelegate <NSObject>

@optional

- (void)downProgress:(NSString *)primary_Id progress:(NSInteger)progress status:(HYUkDownStatus)status;

@end

@interface HYUkDownManager : NSObject

+ (HYUkDownManager *)sharedInstance;

- (void)startNetworkMonitoring;

@property (nonatomic, assign) BOOL isWan;

@property (nonatomic, weak) id <HYUkDownManagerDelegate> delegate;

//@property (nonatomic, strong) NSMutableArray *downIngArray; //下载中的primary_Id
//@property (nonatomic, strong) NSMutableArray *downPauseArray; // 暂停下载的primary_Id
//@property (nonatomic, strong) NSMutableArray *downWaitArray; //排队的primary_Id

@property (nonatomic, strong) NSMutableDictionary *downIngDic; //下载中的primary_Id
@property (nonatomic, strong) NSMutableDictionary *downWaitDic; //下载中的primary_Id

- (void)startDown:(HYUkDownListModel *)model;

- (void)removeCacheForURLs:(NSArray *)urls;

- (void)endDown:(HYUkDownListModel *)model;

@end

NS_ASSUME_NONNULL_END
