//
//  HYUkDownEditView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/16.
//

#import "HYUkDownEditView.h"

@interface HYUkDownEditView()

@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIButton *downBtn;

@end

@implementation HYUkDownEditView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOpacity = 0.1;
    float shawodPathWidth = self.layer.shadowRadius;
    CGRect shawodRect = CGRectMake(0, 0 - shawodPathWidth / 2.0, SCREEN_WIDTH, shawodPathWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shawodRect];
    self.layer.shadowPath = path.CGPath;
    
    self.downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.downBtn setTitle:@"全部下载" forState:0];
    self.downBtn.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(16)];
    self.downBtn.tag = 1;
    [self.downBtn setTitleColor:UIColor.mainColor forState:0];
    [self addSubview:self.downBtn];
    [self.downBtn addTarget:self action:@selector(downButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.qmui_borderPosition = QMUIViewBorderPositionRight|QMUIViewBorderPositionBottom;
    
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.width.mas_equalTo(@(SCREEN_WIDTH / 2.0));
        make.height.mas_equalTo(@(46));
    }];
    
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearBtn setTitle:@"全部删除" forState:0];
    [self.clearBtn setTitleColor:UIColor.mainColor forState:0];
    self.clearBtn.tag = 2;
    self.clearBtn.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(16)];
    [self addSubview:self.clearBtn];
    [self.clearBtn addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.clearBtn.qmui_borderPosition = QMUIViewBorderPositionRight|QMUIViewBorderPositionBottom;

    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downBtn.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.width.mas_equalTo(@(SCREEN_WIDTH / 2.0));
        make.height.mas_equalTo(@(46));

    }];
}



- (void)downButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@(sender.tag)];
    }
}

- (void)clearButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@(sender.tag)];
    }
}


@end
