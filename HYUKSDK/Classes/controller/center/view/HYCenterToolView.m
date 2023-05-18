//
//  HYCenterToolView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/4.
//

#import "HYCenterToolView.h"

@interface HYCenterToolView()<HYBaseViewDelegate>

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) QMUIButton *collectionBtn;
@property (nonatomic, strong) QMUIButton *downBtn;
@property (nonatomic, strong) QMUIButton *shareBtn;
//@property (nonatomic, strong) QMUIButton *messageBtn;
@property (nonatomic, strong) QMUIButton *settingBtn;

@end

@implementation HYCenterToolView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 12.0;
    self.layer.masksToBounds = YES;
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:16];
    self.name.textColor = UIColor.textColor22;
    self.name.text = @"常用功能";
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_offset(50);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.collectionBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.collectionBtn setTitle:@"我的收藏" forState:0];
    [self.collectionBtn setTitleColor:UIColor.textColor22 forState:0];
    self.collectionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.collectionBtn setImage:[UIImage uk_bundleImage:@"uk_center_collection"] forState:0];
    [self.collectionBtn setImagePosition:QMUIButtonImagePositionTop];
    self.collectionBtn.spacingBetweenImageAndTitle = 10;
    self.collectionBtn.tag = 1;
    [self addSubview:self.collectionBtn];
    [self.collectionBtn addTarget:self action:@selector(collectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.downBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.downBtn setTitle:@"我的下载" forState:0];
    [self.downBtn setTitleColor:UIColor.textColor22 forState:0];
    self.downBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.downBtn setImage:[UIImage uk_bundleImage:@"uk_down_Img"] forState:0];
    [self.downBtn setImagePosition:QMUIButtonImagePositionTop];
    self.downBtn.spacingBetweenImageAndTitle = 10;
    self.downBtn.tag = 2;
    [self addSubview:self.downBtn];
    [self.downBtn addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setTitle:@"分享APP" forState:0];
    [self.shareBtn setTitleColor:UIColor.textColor22 forState:0];
    self.shareBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.shareBtn setImage:[UIImage uk_bundleImage:@"uk_fenxiang"] forState:0];
    [self.shareBtn setImagePosition:QMUIButtonImagePositionTop];
    self.shareBtn.spacingBetweenImageAndTitle = 10;
    self.shareBtn.tag = 3;
    [self addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
//    self.messageBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
//    [self.messageBtn setTitle:@"消息" forState:0];
//    [self.messageBtn setTitleColor:UIColor.textColor22 forState:0];
//    self.messageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [self.messageBtn setImage:[UIImage uk_bundleImage:@"xiaoxi1"] forState:0];
//    [self.messageBtn setImagePosition:QMUIButtonImagePositionTop];
//    self.messageBtn.spacingBetweenImageAndTitle = 10;
//    self.messageBtn.tag = 4;
//    [self addSubview:self.messageBtn];
//    [self.messageBtn addTarget:self action:@selector(messageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.settingBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.settingBtn setTitle:@"消息" forState:0];
    [self.settingBtn setTitleColor:UIColor.textColor22 forState:0];
    self.settingBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.settingBtn setImage:[UIImage uk_bundleImage:@"uk_setting_message"] forState:0];
    [self.settingBtn setImagePosition:QMUIButtonImagePositionTop];
    self.settingBtn.spacingBetweenImageAndTitle = 10;
    self.settingBtn.tag = 4;
    [self addSubview:self.settingBtn];
    [self.settingBtn addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat w = 60;
    CGFloat space = (SCREEN_WIDTH - 30 - w * 4) / 5;
    
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(space);
        make.width.mas_offset(w);
        make.top.equalTo(self.name.mas_bottom).offset(0);
    }];
    
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionBtn.mas_right).offset(space);
        make.width.mas_offset(w);
        make.top.equalTo(self.name.mas_bottom).offset(0);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downBtn.mas_right).offset(space);
        make.width.mas_offset(w);
        make.top.equalTo(self.name.mas_bottom).offset(0);
    }];
    
//    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.shareBtn.mas_right).offset(space);
//        make.width.mas_offset(w);
//        make.top.equalTo(self.name.mas_bottom).offset(0);
//    }];
    
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareBtn.mas_right).offset(space);
        make.width.mas_offset(w);
        make.top.equalTo(self.name.mas_bottom).offset(0);
    }];
}

- (void)collectionButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@"1"];
    }
}

- (void)downButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@"2"];
    }
}

- (void)shareButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@"3"];
    }
}

//- (void)messageButtonClick {
//
//}

- (void)settingButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@"4"];
    }
}

@end
