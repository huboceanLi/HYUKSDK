//
//  HYUkVideoDetailModel.h
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HYUkVideoDetailItemModel;

@interface HYUkVideoDetailModel : CommonBaseModel

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger vod_id;
@property (nonatomic, assign) NSInteger type_id;
@property (nonatomic, assign) NSInteger type_id_1;
@property (nonatomic, assign) NSInteger vod_status;
@property (nonatomic, assign) NSInteger vod_total;
@property (nonatomic, strong) NSString *vod_name;
@property (nonatomic, strong) NSString *vod_sub;
@property (nonatomic, strong) NSString *vod_class;
@property (nonatomic, strong) NSString *vod_pic;
@property (nonatomic, strong) NSString *vod_actor;
@property (nonatomic, strong) NSString *vod_director;
@property (nonatomic, strong) NSString *vod_writer;
@property (nonatomic, strong) NSString *vod_blurb;
@property (nonatomic, strong) NSString *vod_remarks;
@property (nonatomic, strong) NSString *vod_pubdate;
@property (nonatomic, strong) NSString *vod_area;
@property (nonatomic, strong) NSString *vod_lang;
@property (nonatomic, strong) NSString *vod_year;
@property (nonatomic, strong) NSString *vod_author;
@property (nonatomic, strong) NSString *vod_douban_id;
@property (nonatomic, strong) NSString *vod_douban_score;
@property (nonatomic, strong) NSString *vod_content;
@property (nonatomic, strong) NSString *type_name;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray <HYUkVideoDetailItemModel *>*vod_play_url;

@end

@interface HYUkVideoDetailItemModel : CommonBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
