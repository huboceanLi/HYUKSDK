//
//  HYUkHomeSearchView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/4/28.
//

#import "HYUkHomeSearchView.h"

@interface HYUkHomeSearchView()

@property (nonatomic, strong) UIView *searchContentView;
@property (nonatomic, strong) UILabel *name;

@end

@implementation HYUkHomeSearchView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;

    self.searchContentView = [UIView new];
    self.searchContentView.layer.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.5].CGColor;
    self.searchContentView.layer.cornerRadius = 16.0;
    self.searchContentView.layer.masksToBounds = YES;
    [self addSubview:self.searchContentView];
    
    UIImageView *searchImageView = [UIImageView new];
    searchImageView.image = [UIImage uk_bundleImage:@"sousuo1"];
    [self.searchContentView addSubview:searchImageView];
    
    self.name = [UILabel new];
    self.name.text = @"请输入关键词";
    self.name.textColor = UIColor.lightGrayColor;
    self.name.font = [UIFont systemFontOfSize:14];
    [self.searchContentView addSubview:self.name];
    
    [self.searchContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(32);
    }];
    
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchContentView.mas_left).offset(10);
        make.centerY.equalTo(self.searchContentView);
        make.height.width.mas_equalTo(20);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.searchContentView);
        make.left.equalTo(searchImageView.mas_right).offset(8);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self addGestureRecognizer:tap];
}

- (void)viewTap {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:nil];
    }
}

@end
