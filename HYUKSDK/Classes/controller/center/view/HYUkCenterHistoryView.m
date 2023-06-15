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
    self.layer.cornerRadius = IS_IPAD ? 18.0 : 12.0;
    self.layer.masksToBounds = YES;
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:XJFlexibleFont(16)];
    self.name.textColor = UIColor.textColor22;
    self.name.text = @"观看历史";
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_offset(XJFlexibleFont(50));
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.moreBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setTitle:@"更多" forState:0];
    [self.moreBtn setTitleColor:UIColor.textColor99 forState:0];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(13)];
    [self.moreBtn setImage:[UIImage uk_bundleImage:@"uk_video_arrow"] forState:0];
    [self.moreBtn setImagePosition:QMUIButtonImagePositionRight];
    self.moreBtn.spacingBetweenImageAndTitle = 0;
    [self addSubview:self.moreBtn];
    [self.moreBtn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.mas_offset(XJFlexibleFont(50));
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.listView = [HYUkCenterHistoryListView new];
    self.listView.delegate = self;
    [self addSubview:self.listView];
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_offset(XJFlexibleFont(90));
    }];
}

- (void)moreButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@{@"type":@"more",@"tvId":@""}];
    }
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@{@"type":@"push",@"tvId":event}];
    }
}

- (void)loadContent {
    
    NSMutableArray *arr = [self.data mutableCopy];
    
    if (arr.count >= 7) {
        [arr removeObject:arr.lastObject];
        self.moreBtn.hidden = NO;
    }else {
        self.moreBtn.hidden = YES;
    }
    self.listView.data = [arr mutableCopy];
    [self.listView loadContent];
}

@end
