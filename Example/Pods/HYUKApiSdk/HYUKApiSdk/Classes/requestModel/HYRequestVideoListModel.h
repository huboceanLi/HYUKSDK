//
//  HYRequestVideoListModel.h
//  HYUKSDK_Example
//
//  Created by oceanMAC on 2023/4/28.
//  Copyright © 2023 li437277219@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYRequestCategeryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYRequestVideoListModel : NSObject

@property (nonatomic, strong) HYRequestCategeryModel *categeryModel;
@property (nonatomic, assign) NSInteger page;

@end

NS_ASSUME_NONNULL_END
