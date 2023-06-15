//
//  HYUkHistoryHeadView.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/4/28.
//

#import "HYUkHistoryHeadView.h"

@implementation HYUkHistoryHeadView

- (void)initSubviews {
    [super initSubviews];
 
    UILabel *name = [UILabel new];
    name.text = @"历史搜索";
    name.font = [UIFont boldSystemFontOfSize:XJFlexibleFont(17)];
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self);
    }];
    
    QMUIButton *clearBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [clearBtn setTitle:@"清除" forState:0];
    [clearBtn setTitleColor:UIColor.textColor99 forState:0];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(14)];
    [clearBtn setImage:[UIImage uk_bundleImage:@"uk_center_delete"] forState:0];
    [clearBtn setImagePosition:QMUIButtonImagePositionLeft];
    clearBtn.spacingBetweenImageAndTitle = 5;
    [self addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
    }];
}

@end
