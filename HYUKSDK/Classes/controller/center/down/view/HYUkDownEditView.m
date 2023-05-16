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
@property (nonatomic, strong) UIButton *deleteAppointBtn;

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
    self.downBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.downBtn.tag = 1;
    [self.downBtn setTitleColor:UIColor.mainColor forState:0];
    [self addSubview:self.downBtn];
    [self.downBtn addTarget:self action:@selector(downButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.qmui_borderPosition = QMUIViewBorderPositionRight|QMUIViewBorderPositionBottom;
    
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.width.mas_equalTo(@(50));
        make.height.mas_equalTo(@(46));
    }];
    
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearBtn setTitle:@"全部删除" forState:0];
    [self.clearBtn setTitleColor:UIColor.mainColor forState:0];
    self.clearBtn.tag = 2;
    self.clearBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.clearBtn];
    [self.clearBtn addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.clearBtn.qmui_borderPosition = QMUIViewBorderPositionRight|QMUIViewBorderPositionBottom;

    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downBtn.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.width.mas_equalTo(@(50));
        make.height.mas_equalTo(@(46));

    }];
    
    self.deleteAppointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteAppointBtn setTitle:@"指定删除" forState:0];
    self.deleteAppointBtn.tag = 3;
    [self.deleteAppointBtn setTitleColor:UIColor.mainColor forState:0];
    self.deleteAppointBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.deleteAppointBtn];
    self.deleteAppointBtn.qmui_borderPosition = QMUIViewBorderPositionBottom;
    [self.deleteAppointBtn addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.deleteAppointBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clearBtn.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.width.mas_equalTo(@(50));
        make.height.mas_equalTo(@(46));
    }];
}

- (void)changeUI:(BOOL)isDown
{
    self.downBtn.hidden = !isDown;
    CGFloat bw = SCREEN_WIDTH / 3.0;
    if (!isDown) {
        bw = SCREEN_WIDTH / 2.0;
        [self.downBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(0));
        }];
        
        [self.clearBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(bw));
        }];
        
        [self.deleteAppointBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(bw));
        }];
    }else {
        [self.downBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(bw));
        }];
        
        [self.clearBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(bw));
        }];
        
        [self.deleteAppointBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(bw));
        }];
    }

    

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

- (void)deleteButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@(sender.tag)];
    }
}

@end
