//
//  HYUkDetailViewController.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import <HYBaseTool/HYBaseTool.h>
#import "HYUkVideoBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HYUkDetailViewDelegate <NSObject>

@optional

- (void)changeLikeStatus:(BOOL)isLike videoId:(NSInteger)videoId;

- (void)changeVideoProgressVideoId:(NSInteger)videoId;

@end

@interface HYUkDetailViewController : HYUkVideoBaseViewController

@property (nonatomic, assign) NSInteger videoId;

//@property (copy, nonatomic) void (^changeLikeStatuBlock)(BOOL isLike, NSInteger videoId);

@property (nonatomic, weak) id <HYUkDetailViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
