//
//  HYUkVideoDetailBriefView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYUkVideoDetailBriefView.h"

@interface HYUkVideoDetailBriefView()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *des;
@property (nonatomic, strong) QMUIButton *moreBtn;

@end

@implementation HYUkVideoDetailBriefView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:16];
    self.name.textColor = UIColor.textColor22;
    [self addSubview:self.name];
    
    self.des = [UILabel new];
    self.des.font = [UIFont systemFontOfSize:13];
    self.des.textColor = UIColor.textColor99;
    [self addSubview:self.des];
    
    self.moreBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setTitle:@"简介" forState:0];
    [self.moreBtn setTitleColor:UIColor.textColor99 forState:0];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.moreBtn setImage:[UIImage uk_bundleImage:@"jinrujiantou"] forState:0];
    [self.moreBtn setImagePosition:QMUIButtonImagePositionRight];
    self.moreBtn.spacingBetweenImageAndTitle = 0;
    [self addSubview:self.moreBtn];
    [self.moreBtn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_offset(20);
    }];
    
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.name.mas_bottom).offset(6);
        make.height.mas_offset(16);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-8);
        make.top.equalTo(self.mas_top).offset(12);
        make.height.mas_offset(20);
    }];
    
}

- (void)loadContent
{
    HYUkVideoDetailModel *model = self.data;
    self.name.text = model.vod_name;
    NSString *s = [NSString stringWithFormat:@"%@,%@",model.vod_area,model.vod_class];
    s = [s stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    self.des.text = s;
}


- (void)moreButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:nil];
    }
}

@end
