//
//  HYBaseHeaderFooterView.m
//  AmyNew
//
//  Created by chong on 2018/12/21.
//  Copyright © 2018 chong. All rights reserved.
//

#import "HYBaseHeaderFooterView.h"

@implementation HYBaseHeaderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupHeaderFooterView];
        [self buildSubview];
    }
    
    return self;
}

- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color {
    
    self.contentView.backgroundColor = color;
}

- (void)setupHeaderFooterView {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

+ (CGFloat)heightWithData:(id)data {
    
    return 0;
}

@end
