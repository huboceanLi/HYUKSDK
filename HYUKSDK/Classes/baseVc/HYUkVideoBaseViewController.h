//
//  HYUkVideoBaseViewController.h
//  HYVideoSDK_Example
//
//  Created by oceanMAC on 2023/3/31.
//  Copyright © 2023 admin@buzzmsg.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUkVideoBaseViewController : UIViewController

@property(strong,nonatomic)UIView *navBar;
@property(strong,nonatomic) UIButton *navBackButton;
@property(strong,nonatomic) UILabel *navTitleLabel;
@property(strong,nonatomic) UIImageView *bgImageView;


- (void)clickedBackButton:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
