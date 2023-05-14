//
//  HYUkVideoPlayView.h
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/14.
//

#import <HYBaseTool/HYBaseTool.h>
#import "HYUkHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface HYUkVideoPlayView : HYBaseView

- (void)saveHistoryRecord;

- (void)changeSelect:(NSString *)name Url:(NSString *)url;

- (void)removeView;

@end

NS_ASSUME_NONNULL_END
