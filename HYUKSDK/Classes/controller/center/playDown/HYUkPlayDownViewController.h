//
//  HYUkPlayDownViewController.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/16.
//

#import <HYBaseTool/HYBaseTool.h>
#import "HYUkVideoBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class HYUkDownListModel;

@interface HYUkPlayDownViewController : HYUkVideoBaseViewController

@property (nonatomic, strong) HYUkDownListModel *downModel;

@end

NS_ASSUME_NONNULL_END
