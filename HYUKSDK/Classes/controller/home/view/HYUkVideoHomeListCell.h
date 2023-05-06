//
//  HYUkVideoHomeListCell.h
//  CocoaAsyncSocket
//
//  Created by oceanMAC on 2023/4/10.
//

#import <UIKit/UIKit.h>
#import <HYBaseTool/HYBaseTool.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUkVideoHomeListCell : HYBaseCollectionViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *des;
@property (nonatomic, strong) UILabel *scoreLab;

@end

NS_ASSUME_NONNULL_END
