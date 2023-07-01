//
//  HYUKBadgeView.m
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/7/1.
//

#import "HYUKBadgeView.h"

@interface HYUKBadgeView()

@property (nonatomic, strong) UIImageView *messageImagView;
@property (nonatomic, strong) UILabel *badgeLab;

@end

@implementation HYUKBadgeView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;
    
    UITapGestureRecognizer *previewRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
    [self addGestureRecognizer:previewRecognizer1];
    
    self.messageImagView = [UIImageView new];
    self.messageImagView.contentMode = UIViewContentModeScaleAspectFit;
    self.messageImagView.image = [UIImage uk_bundleImage:@"uk_message"];
    [self addSubview:self.messageImagView];
    
    [self.messageImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.width.height.mas_equalTo(24);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    self.badgeLab = [UILabel new];
    self.badgeLab.layer.cornerRadius = 9.0;
    self.badgeLab.layer.masksToBounds = YES;
    self.badgeLab.textAlignment = NSTextAlignmentCenter;
    self.badgeLab.font = [UIFont systemFontOfSize:11];
    self.badgeLab.textColor = UIColor.whiteColor;
    self.badgeLab.backgroundColor = UIColor.redColor;
    self.badgeLab.text = @"89";
    [self addSubview:self.badgeLab];
    [self.badgeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(18);
    }];
}

- (void)getCount:(NSInteger)count
{
    if (count > 99) {
        self.badgeLab.hidden = false;
        [self.badgeLab setText:@"99+"];
        
        [self.messageImagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(4);
        }];
        
        [self.badgeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(26);
        }];
    } else if (count > 0) {
        self.badgeLab.hidden = false;
        [self.badgeLab setText:[NSString stringWithFormat:@"%ld",count]];
        
        [self.messageImagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(13);
        }];
        
        [self.badgeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(18);
        }];
    } else {
        self.badgeLab.hidden = true;
        [self.badgeLab setText:@""];
        
        [self.messageImagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(13);
        }];
    }
}

- (void)singleTap {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:nil];
    }
}
@end
