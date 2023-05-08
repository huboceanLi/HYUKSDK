//
//  HYUkDetailViewController.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import <HYBaseTool/HYBaseTool.h>
#import "HYUkVideoBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUkDetailViewController : HYUkVideoBaseViewController

@property (nonatomic, assign) NSInteger videoId;

@property (copy, nonatomic) void (^changeLikeStatuBlock)(BOOL isLike, NSInteger videoId);

@end

NS_ASSUME_NONNULL_END
