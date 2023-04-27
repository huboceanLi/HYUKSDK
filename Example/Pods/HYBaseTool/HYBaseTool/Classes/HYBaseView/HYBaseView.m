//
//  HYBaseView.m
//  AMStore
//
//  Created by chong on 2019/2/14.
//  Copyright © 2019 chong. All rights reserved.
//

#import "HYBaseView.h"

@implementation HYBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self setupView];
        [self initSubviews];
    }
    return self;
}

- (void)initData
{}

- (void)initSubviews
{}

- (void)setupView
{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)loadContent
{}

@end
