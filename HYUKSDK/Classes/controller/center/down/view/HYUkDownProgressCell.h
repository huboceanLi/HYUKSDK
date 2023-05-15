//
//  HYUkDownProgressCell.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import <HYBaseTool/HYBaseTool.h>
#import "HYUkHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface HYUkDownProgressCell : HYBaseTableViewCell

- (void)downProgress:(NSString *)primary_Id progress:(NSInteger)progress status:(HYUkDownStatus)status;

@end

NS_ASSUME_NONNULL_END
