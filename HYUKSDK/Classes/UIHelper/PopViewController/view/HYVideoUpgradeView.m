//
//  HYVideoUpgradeView.m
//  CocoaAsyncSocket
//
//  Created by oceanMAC on 2023/4/6.
//

#import "HYVideoUpgradeView.h"
#import <YYCategories/YYCategories.h>

@interface HYVideoUpgradeView()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, assign) CGFloat imageH;
@property (nonatomic, strong) UIView *bgView;


@end

@implementation HYVideoUpgradeView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;

    
    UIImage *img = [UIImage uk_bundleImage:@"bg_gengxin"];
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = img;
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    self.imageH = img.size.height * (SCREEN_WIDTH - 140) / img.size.width;
    
    bgImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 140, self.imageH);
    
    self.bgView = [UIView new];
    self.bgView.backgroundColor = UIColor.whiteColor;
    self.bgView.layer.cornerRadius = XJFlexibleFont(6);
    self.bgView.layer.masksToBounds = YES;
    [self addSubview:self.bgView];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.numberOfLines = 0;
    tipLabel.backgroundColor = UIColor.clearColor;
    tipLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(14)];
    tipLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:0.7];
    [self.bgView addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    
    self.upgradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.upgradeButton];
    [self.upgradeButton setTitle:@"升级" forState:0];
    [self.upgradeButton setTitleColor:UIColor.whiteColor forState:0];
    self.upgradeButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.upgradeButton.layer.cornerRadius = XJFlexibleFont(22);
    self.upgradeButton.layer.shadowRadius = XJFlexibleFont(10);
    self.upgradeButton.backgroundColor = UIColor.mainColor;
    self.upgradeButton.layer.shadowOffset = CGSizeMake(0, XJFlexibleFont(5));
    self.upgradeButton.layer.shadowColor = UIColor.mainColor.CGColor;
    self.upgradeButton.layer.shadowOpacity = 1.0;
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.closeButton];
    [self.closeButton setImage:[UIImage uk_bundleImage:@"uk_close_update"] forState:0];
    self.closeButton.hidden = YES;
}

- (CGFloat) contentViewHeight
{
//    NSString *str = @"比如我本来安装完CocoaPods 1.0.0版,但发现它实现跟先前还是差别满大的,决定降回0.39这个比较稳定版本;就可以用命令先删除本地的CocoaPods版本,再指定安装特定版本。";
//    NSString *str = [HYUKConfigManager shareInstance].versionModel.content;
//
//    self.tipLabel.text = str;
//    CGFloat h = [str heightForFont:[UIFont systemFontOfSize:XJFlexibleFont(14)] width:SCREEN_WIDTH - 180];
//    self.tipLabel.frame = CGRectMake(20, XJFlexibleFont(20), SCREEN_WIDTH - 180, h);
//    self.upgradeButton.frame = CGRectMake((SCREEN_WIDTH - 120 - 140)/2, CGRectGetMaxY(self.tipLabel.frame) + XJFlexibleFont(40), 120, XJFlexibleFont(44));
//    self.bgView.frame = CGRectMake(0, CGRectGetMaxY(self.bgImageView.frame) - XJFlexibleFont(6), SCREEN_WIDTH - 140, h + XJFlexibleFont(20 + 40 + 20 + 44 + 6));
//    
//    self.closeButton.frame = CGRectMake((SCREEN_WIDTH - 140 - 40)/2, CGRectGetMaxY(self.bgView.frame) + XJFlexibleFont(30), XJFlexibleFont(40), XJFlexibleFont(40));
//    
//    CGFloat allH = h + self.imageH + XJFlexibleFont(20 + 40 + 20 + 44 + 6 + 30 + 40);
//    if ([HYUKConfigManager shareInstance].versionModel.force == 2) {
//        allH = allH - XJFlexibleFont(30) - XJFlexibleFont(40);
//        self.closeButton.hidden = YES;
//    }else {
//        self.closeButton.hidden = NO;
//    }
//    return allH;
    return 0.0;
}

@end
