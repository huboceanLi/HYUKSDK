//
//  HYUKResponseNoticeModel.h
//  HYUKSDK
//
//  Created by oceanMAC on 2023/6/29.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HYUKResponseNoticeItemModel;
@interface HYUKResponseNoticeModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray <HYUKResponseNoticeItemModel *>*data;

@end


@interface HYUKResponseNoticeItemModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) BOOL top_switch;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *created_time_text;

@end

NS_ASSUME_NONNULL_END
