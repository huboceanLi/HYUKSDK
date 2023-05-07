//
//  HYUkTempCategaryModel.h
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUkTempCategaryModel : NSObject

@property (nonatomic, strong) NSString *vod_area;
@property (nonatomic, strong) NSString *vod_lang;
@property (nonatomic, strong) NSString *vod_year;
@property (nonatomic, strong) NSString *order;
@property (nonatomic, assign) NSInteger type_id;

@end

NS_ASSUME_NONNULL_END
