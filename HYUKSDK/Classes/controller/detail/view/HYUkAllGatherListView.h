//
//  HYUkAllGatherListView.h
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/14.
//

#import <HYBaseTool/HYBaseTool.h>
#import "HYUkHeader.h"
NS_ASSUME_NONNULL_BEGIN

@class HYUkHistoryRecordModel;

@interface HYUkAllGatherListView : HYBaseView

- (void)changeSelect:(HYUkHistoryRecordModel *)recordModel;
@property (nonatomic, assign) BOOL isDown;

@end

NS_ASSUME_NONNULL_END
