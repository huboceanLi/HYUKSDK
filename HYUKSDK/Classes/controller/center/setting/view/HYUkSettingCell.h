//
//  HYUkSettingCell.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import <UIKit/UIKit.h>
#import <HYBaseTool/HYBaseTool.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUkSettingCell : HYBaseTableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *briefLab;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

NS_ASSUME_NONNULL_END
