//
//  HYVideoUpgradeView.h
//  CocoaAsyncSocket
//
//  Created by oceanMAC on 2023/4/6.
//

#import <UIKit/UIKit.h>
#import <HYBaseTool/HYBaseTool.h>
#import "HYUkHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface HYVideoUpgradeView : HYBaseView

- (CGFloat) contentViewHeight;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *upgradeButton;

@end

NS_ASSUME_NONNULL_END
