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
        self.layer.cornerRadius = 14.0;
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
        
        self.downImageView = [UIImageView new];
        self.downImageView.contentMode = 1;
        self.downImageView.image = [UIImage uk_bundleImage:@"uk_detail_down"];
        [self addSubview:self.downImageView];
        [self.downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.width.height.mas_equalTo(10);
        }];
        self.downImageView.hidden = YES;
    }
    return self;
}

- (void)loadContent {
//    HYDouBanCategeryTempModel *model = self.data;
//    self.name.text = model.name;
}

@end
