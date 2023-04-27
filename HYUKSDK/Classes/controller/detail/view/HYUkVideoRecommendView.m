//
//  HYUkVideoRecommendView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYUkVideoRecommendView.h"

@interface HYUkVideoRecommendView()

@property (nonatomic, strong) UILabel *name;

@end

@implementation HYUkVideoRecommendView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:16];
    self.name.textColor = UIColor.textColor22;
    self.name.text = @"猜你喜欢";
    [self addSubview:self.name];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_offset(50);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    

}

- (void)loadContent
{
//    self.dataArray = self.data;
//    [self.tableView reloadData];
}


@end
