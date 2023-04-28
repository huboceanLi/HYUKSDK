//
//  HYRequestSearchModel.h
//  HYUKSDK_Example
//
//  Created by oceanMAC on 2023/4/28.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYRequestSearchModel : NSObject

@property (nonatomic, copy) NSString *keyWords;
@property (nonatomic, assign) NSInteger page;

@end

NS_ASSUME_NONNULL_END
