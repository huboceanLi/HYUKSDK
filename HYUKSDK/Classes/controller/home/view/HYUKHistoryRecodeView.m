//
//  HYUKHistoryRecodeView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/6/8.
//

#import "HYUKHistoryRecodeView.h"
#import "HYUKSDK/HYUKSDK-Swift.h"
#import <YYText/YYText.h>

@interface HYUKHistoryRecodeView()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *name;

@end

@implementation HYUKHistoryRecodeView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;
    
    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,3);
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowRadius = 6.0;
    self.clipsToBounds = NO;
    
    self.bgView = [UIView new];
    self.bgView.layer.cornerRadius = XJFlexibleFont(20);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.qmui_maskedCorners = QMUILayerMaxXMinYCorner | QMUILayerMaxXMaxYCorner;
    self.bgView.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.bgView addGestureRecognizer:tap];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(XJFlexibleFont(40));
        make.centerY.equalTo(self);
    }];
    
    self.name = [UILabel new];
    [self.bgView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.bgView);
    }];
}

- (void)loadContent {
    HYUkHistoryRecordModel *recordModel = self.data;
    NSString *t = [NSString stringWithFormat:@"    %@ | ",[[HYUkVideoConfigManager sharedInstance] changeTimeWithDuration:recordModel.playDuration]];
    NSString *name = recordModel.name;

    if (name.length > 7) {
        name = [NSString stringWithFormat:@"%@...",[name substringToIndex:6]];
    }
    NSString *j = @" 继续观看    ";
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",t,name,j]];
    
    att.yy_font = [UIFont systemFontOfSize:13];
    
    
    [att addAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor],NSFontAttributeName: [UIFont systemFontOfSize:XJFlexibleFont(13)]} range:NSMakeRange(0, t.length)];
    [att addAttributes:@{NSForegroundColorAttributeName: [UIColor textColor22],NSFontAttributeName: [UIFont systemFontOfSize:XJFlexibleFont(13)]} range:NSMakeRange(t.length, name.length)];
    [att addAttributes:@{NSForegroundColorAttributeName: [UIColor mainColor],NSFontAttributeName: [UIFont boldSystemFontOfSize:XJFlexibleFont(13)]} range:NSMakeRange(name.length + t.length, j.length)];
    self.name.attributedText = att;
}

- (void)viewTap {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:self.data];
    }
}

@end
