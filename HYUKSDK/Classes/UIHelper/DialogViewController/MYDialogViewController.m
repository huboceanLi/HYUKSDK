//
//  MYDialogViewController.m
//  OrderMeals
//
//  Created by chong on 2020/4/11.
//  Copyright © 2020 chong. All rights reserved.
//

#import "MYDialogViewController.h"

@interface MYDialogViewController ()

@property(nonatomic, strong) NSString * titleStr;
@property(nonatomic, strong) NSString * tipsStr;

@end

@implementation MYDialogViewController

- (instancetype)initWithTitle:(NSString *)title tipsString:(NSString *)tipsString {
    self = [super init];
    if (self) {
        _titleStr = title;
        _tipsStr = tipsString;
        
        self.buttonTitleAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#2897F7"],NSFontAttributeName:UIFontMake(16)};
        self.buttonHighlightedBackgroundColor = [UIColor.mainColor colorWithAlphaComponent:.25];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)initSubviews {
    [super initSubviews];
    
    self.headerViewHeight = 0;
    
    _tipsLabel = [[UILabel alloc] init];
    _tipsLabel.numberOfLines = 0;
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.font = UIFontMake(16);
    _tipsLabel.textColor = [UIColor textColor33];
    _tipsLabel.text = _tipsStr;
    [self.customView addSubview:_tipsLabel];
    
    if (_titleStr) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.textColor22;
        _titleLabel.font = UIFontMediumMake(18);
        _titleLabel.text = _titleStr;
        [self.customView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.customView).offset(22);
            make.centerX.equalTo(self.customView);
        }];
        
        [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
            make.centerX.equalTo(self.customView);
            make.right.lessThanOrEqualTo(self.customView).offset(-30);
        }];
    } else {
        [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.customView);
            make.right.lessThanOrEqualTo(self.customView).offset(-30);
        }];
    }
    
    
}

- (void)addSubmitButtonWithText:(NSString *)buttonText block:(void (^)(__kindof QMUIDialogViewController * _Nonnull))block {
    [super addSubmitButtonWithText:buttonText block:block];

}

- (void)addCancelButtonWithText:(NSString *)buttonText block:(void (^)(__kindof QMUIDialogViewController * _Nonnull))block {
    [super addCancelButtonWithText:buttonText block:block];
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:buttonText];
    attriStr.font = UIFontMake(16);
    attriStr.color = UIColor.textColor99;
    [self.cancelButton setAttributedTitle:attriStr forState:UIControlStateNormal];
}



#pragma mark-- 懒加载
- (UIView *)customView {
    if (!_customView) {
        _customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 80)];
        _customView.backgroundColor = UIColor.whiteColor;
        self.contentView = _customView;
    }
    return _customView;
}
@end
