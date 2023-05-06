//
//  HYResponseVideoListModel.h
//  HYUKSDK_Example
//
//  Created by oceanMAC on 2023/4/28.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYResponseVideoListModel : CommonBaseModel

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger vod_score_num;
@property (nonatomic, strong) NSString *vod_name;
@property (nonatomic, strong) NSString *vod_sub;
@property (nonatomic, strong) NSString *vod_class;
@property (nonatomic, strong) NSString *vod_pic;
@property (nonatomic, strong) NSString *vod_remarks;
@property (nonatomic, strong) NSString *vod_douban_score;

@end

NS_ASSUME_NONNULL_END
