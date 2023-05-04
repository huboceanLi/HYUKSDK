//
//  HYUkCenterHistoryView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/4.
//

#import "HYUkCenterHistoryView.h"
#import "HYUkCenterHistoryListView.h"

@interface HYUkCenterHistoryView()<HYBaseViewDelegate>

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) QMUIButton *moreBtn;
@property (nonatomic, strong) HYUkCenterHistoryListView *listView;

@end

@implementation HYUkCenterHistoryView

- (void)initSubviews {
    [super initSubviews];
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 12.0;
    self.layer.masksToBounds = YES;
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:16];
    self.name.textColor = UIColor.textColor22;
    self.name.text = @"观看历史";
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_offset(50);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.moreBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setTitle:@"更多" forState:0];
    [self.moreBtn setTitleColor:UIColor.textColor99 forState:0];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.moreBtn setImage:[UIImage uk_bundleImage:@"jinrujiantou"] forState:0];
    [self.moreBtn setImagePosition:QMUIButtonImagePositionRight];
    self.moreBtn.spacingBetweenImageAndTitle = 0;
    [self addSubview:self.moreBtn];
    [self.moreBtn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.mas_offset(50);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.listView = [HYUkCenterHistoryListView new];
    self.listView.delegate = self;
    [self addSubview:self.listView];
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_offset(90);
    }];
}

- (void)moreButtonClick {
    
}

@end
