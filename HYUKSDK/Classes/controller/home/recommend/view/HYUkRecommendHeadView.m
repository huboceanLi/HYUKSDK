//
//  HYUkRecommendHeadView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkRecommendHeadView.h"

@implementation HYUkRecommendHeadView


- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:XJFlexibleFont(17)];
    self.name.textColor = [UIColor textColor22];
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.center.equalTo(self);
    }];
}

@end
