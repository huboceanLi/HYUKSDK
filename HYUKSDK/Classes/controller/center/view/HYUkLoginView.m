//
//  HYUkLoginView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/4.
//

#import "HYUkLoginView.h"

@interface HYUkLoginView()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *IDLab;
@property (nonatomic, strong) UILabel *noLoginLab;

@end

@implementation HYUkLoginView

- (void)initSubviews {
    [super initSubviews];
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 12.0;
    self.layer.masksToBounds = YES;
    
    self.headImageView = [UIImageView new];
    [self addSubview:self.headImageView];
    self.headImageView.layer.borderWidth = 4.0f;
    self.headImageView.image = [UIImage uk_bundleImage:@"morentouxiang"];
    self.headImageView.layer.borderColor = [[UIColor colorWithHexString:@"#DDDDDD"] colorWithAlphaComponent:0.4].CGColor;
    self.headImageView.layer.cornerRadius = 30.0f;
    self.headImageView.layer.masksToBounds = YES;
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(60);
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:18];
    self.name.textColor = UIColor.blackColor;
//    self.name.text = @"我是小强";
    [self addSubview:self.name];

    self.IDLab = [UILabel new];
    self.IDLab.font = [UIFont systemFontOfSize:15];
    self.IDLab.textColor = UIColor.lightGrayColor;
//    self.IDLab.text = @"2134567890";
    [self addSubview:self.IDLab];

    self.noLoginLab = [UILabel new];
    self.noLoginLab.font = [UIFont boldSystemFontOfSize:20];
    self.noLoginLab.textColor = UIColor.blackColor;
    self.noLoginLab.text = @"点击登录";
    [self addSubview:self.noLoginLab];

    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.mas_offset(20);
       make.top.equalTo(self.headImageView.mas_top).offset(8);
       make.right.equalTo(self.mas_right).offset(-15);
       make.left.equalTo(self.headImageView.mas_right).offset(15);
    }];

    [self.IDLab mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.mas_offset(20);
       make.bottom.equalTo(self.headImageView.mas_bottom).offset(-8);
       make.right.equalTo(self.mas_right).offset(-15);
       make.left.equalTo(self.headImageView.mas_right).offset(15);
    }];

    [self.noLoginLab mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.mas_offset(30);
       make.centerY.equalTo(self.headImageView);
       make.right.equalTo(self.mas_right).offset(-15);
       make.left.equalTo(self.headImageView.mas_right).offset(15);
    }];
}

@end
