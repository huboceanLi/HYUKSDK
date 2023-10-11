//
//  HYUkRankViewCell.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import <UIKit/UIKit.h>
#import <HYBaseTool/HYBaseTool.h>
#import "HYUkHeader.h"
#import "HYUkRankClassView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUkRankViewCell : HYBaseTableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UILabel *briefLab;
@property (nonatomic, strong) HYUkRankClassView *tagView;

@end

NS_ASSUME_NONNULL_END
