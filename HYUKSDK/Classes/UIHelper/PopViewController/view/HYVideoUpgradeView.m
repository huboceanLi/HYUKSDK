//
//  HYVideoUpgradeView.m
//  CocoaAsyncSocket
//
//  Created by oceanMAC on 2023/4/6.
//

#import "HYVideoUpgradeView.h"

@interface HYVideoUpgradeView()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *upgradeButton;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, assign) CGFloat imageH;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation HYVideoUpgradeView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;

    
    UIImage *img = [UIImage sdk_bundleImage:@"bg_gengxin"];
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = img;
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    self.imageH = img.size.height * (SCREEN_WIDTH - 140) / img.size.width;
    
    bgImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 140, self.imageH);
    
    self.bgView = [UIView new];
    self.bgView.backgroundColor = UIColor.whiteColor;
    self.bgView.layer.cornerRadius = 6.0;
    self.bgView.layer.masksToBounds = YES;
    [self addSubview:self.bgView];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.numberOfLines = 0;
    tipLabel.backgroundColor = UIColor.clearColor;
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:0.7];
    [self.bgView addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    
    self.upgradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.upgradeButton];
    [self.upgradeButton setTitle:@"升级" forState:0];
    [self.upgradeButton setTitleColor:UIColor.whiteColor forState:0];
    self.upgradeButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.upgradeButton.layer.cornerRadius = 22;
    self.upgradeButton.layer.shadowRadius = 10;
    self.upgradeButton.backgroundColor = UIColor.mainColor;
    self.upgradeButton.layer.shadowOffset = CGSizeMake(0, 5);
    self.upgradeButton.layer.shadowColor = UIColor.mainColor.CGColor;
    self.upgradeButton.layer.shadowOpacity = 1.0;
    

}

- (CGFloat) contentViewHeight
{
    NSString *str = @"比如我本来安装完CocoaPods 1.0.0版,但发现它实现跟先前还是差别满大的,决定降回0.39这个比较稳定版本;就可以用命令先删除本地的CocoaPods版本,再指定安装特定版本。";
    self.tipLabel.text = str;
    CGFloat h = [str heightForFont:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH - 180];
    self.tipLabel.frame = CGRectMake(20, 20, SCREEN_WIDTH - 180, h);
    self.upgradeButton.frame = CGRectMake((SCREEN_WIDTH - 120 - 140)/2, CGRectGetMaxY(self.tipLabel.frame) + 40, 120, 44);
    self.bgView.frame = CGRectMake(0, CGRectGetMaxY(self.bgImageView.frame) - 6, SCREEN_WIDTH - 140, h + 20 + 40 + 20 + 44 + 6);
    return h + self.imageH + 20 + 40 + 20 + 44 + 6;
}

@end
