//
//  HYRequestCategeryModel.h
//  HYUKSDK_Example
//
//  Created by oceanMAC on 2023/4/28.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYRequestCategeryModel : NSObject

@property (nonatomic, assign) NSInteger videoTyep;//电影、电视剧、综艺等
@property (nonatomic, assign) NSInteger hotType; //最新、最热、好评
@property (nonatomic, assign) NSInteger categeryType;//喜剧、动作等
@property (nonatomic, assign) NSInteger areaType;//大陆、香港、美国等
@property (nonatomic, assign) NSInteger langType;//国语、英语等
@property (nonatomic, assign) NSInteger yearType; //年份

@end

NS_ASSUME_NONNULL_END
