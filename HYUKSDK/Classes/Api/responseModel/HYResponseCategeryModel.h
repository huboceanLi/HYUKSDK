//
//  HYResponseCategeryModel.h
//  HYUKSDK_Example
//
//  Created by oceanMAC on 2023/4/28.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HYResponseCategeryTypeModel;

@interface HYResponseCategeryModel : CommonBaseModel

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *order;
@property (nonatomic, strong) NSArray <HYResponseCategeryTypeModel *>*type;
@property (nonatomic, strong) NSArray *vod_year;
@property (nonatomic, strong) NSArray *vod_area;
@property (nonatomic, strong) NSArray *vod_lang;

@end

@interface HYResponseCategeryTypeModel : CommonBaseModel

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
