//
//  HYResponseSearchModel.h
//  HYUKSDK_Example
//
//  Created by oceanMAC on 2023/4/28.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYResponseSearchModel : CommonBaseModel

@property (nonatomic, assign) NSInteger video_id;
@property (nonatomic, assign) NSInteger type_id;
@property (nonatomic, assign) NSInteger type_id_1;
@property (nonatomic, assign) NSInteger vod_total;
@property (nonatomic, assign) NSInteger vod_score_num;

@property (nonatomic, strong) NSString *vod_name;
@property (nonatomic, strong) NSString *vod_class;
@property (nonatomic, strong) NSString *vod_pic;
@property (nonatomic, strong) NSString *vod_blurb;
@property (nonatomic, strong) NSString *vod_remarks;
@property (nonatomic, strong) NSString *vod_pubdate;
@property (nonatomic, strong) NSString *vod_area;
@property (nonatomic, strong) NSString *vod_lang;
@property (nonatomic, strong) NSString *vod_year;
@property (nonatomic, strong) NSString *vod_douban_score;
@property (nonatomic, strong) NSString *vod_content;
@property (nonatomic, strong) NSString *type_name;

@end

NS_ASSUME_NONNULL_END
