//
//  HYUkVideoDetailSelectWorkView.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/13.
//

#import <HYBaseTool/HYBaseTool.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class HYUkHistoryRecordModel;

@interface HYUkVideoDetailSelectWorkView : HYBaseView

- (void)changeSelect:(HYUkHistoryRecordModel *)recordModel;

@end

NS_ASSUME_NONNULL_END
