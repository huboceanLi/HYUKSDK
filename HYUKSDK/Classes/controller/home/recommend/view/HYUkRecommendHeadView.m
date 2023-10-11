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
    self.name.font = [UIFont boldSystemFontOfSize:XJFlexibleFont(18)];
    self.name.textColor = [UIColor textColor22];
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.center.equalTo(self);
    }];
}

- (void)showTitle:(NSInteger)index dic:(NSDictionary *)dic
{
    NSArray *arr = dic.allKeys;
    if ([arr containsObject:@"1"] && index == 0) {
        NSArray *da = dic[@"1"];
        self.name.text = @"电影";
    }
    
    if ([arr containsObject:@"2"] && index == 1) {
        NSArray *da = dic[@"2"];
        self.name.text = @"电视剧";
    }
    
    if ([arr containsObject:@"3"] && index == 2) {
        NSArray *da = dic[@"3"];
        self.name.text = @"综艺";
    }
    
    if ([arr containsObject:@"4"] && index == 3) {
        NSArray *da = dic[@"4"];
        self.name.text = @"动漫";
    }
    
    if ([arr containsObject:@"24"] && index == 4) {
        NSArray *da = dic[@"24"];
        self.name.text = @"记录片";
    }
}

@end
