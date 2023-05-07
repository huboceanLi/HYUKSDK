//
//  HYUkDetailErrorView.m
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/7.
//

#import "HYUkDetailErrorView.h"

@interface HYUkDetailErrorView()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *showImageView;

@end

@implementation HYUkDetailErrorView

- (void)initSubviews {
    [super initSubviews];
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:18];
    self.name.textColor = UIColor.textColor22;
    self.name.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.name];
    
    self.showImageView = [UIImageView new];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.showImageView];
    
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(240);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(-30);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.top.equalTo(self.showImageView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
    }];
}

- (void)showImageName:(NSString *)imageName TitleString:(NSString *)name
{
    self.showImageView.image = [UIImage uk_bundleImage:imageName];
    self.name.text = name;
}

@end
