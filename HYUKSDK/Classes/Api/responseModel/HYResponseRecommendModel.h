//
//  HYResponseRecommendModel.h
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

#import <Foundation/Foundation.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYResponseRecommendModel : CommonBaseModel

@property (nonatomic, assign) NSInteger video_id;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger type_id;
@property (nonatomic, assign) NSInteger type_id_1;
@property (nonatomic, assign) NSInteger vod_total;
@property (nonatomic, assign) NSInteger vod_score_num;
@property (nonatomic, assign) NSInteger created_time;
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
