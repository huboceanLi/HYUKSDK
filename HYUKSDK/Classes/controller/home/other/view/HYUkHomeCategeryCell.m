//
//  HYUkHomeCategeryCell.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/24.
//

#import "HYUkHomeCategeryCell.h"

@interface HYUkHomeCategeryCell()


@end

@implementation HYUkHomeCategeryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = UIColor.clearColor;
        self.layer.cornerRadius = 15.0;
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        
        self.name = [UILabel new];
        self.name.font = [UIFont systemFontOfSize:13];
        self.name.textColor = [UIColor mainColor];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.name];
        self.name.backgroundColor = UIColor.clearColor;
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (void)loadContent {
//    HYDouBanCategeryTempModel *model = self.data;
//    self.name.text = model.name;
}

@end
