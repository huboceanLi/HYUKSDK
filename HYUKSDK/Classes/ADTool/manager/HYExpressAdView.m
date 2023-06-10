//
//  HYExpressAdView.m
//  HYUKADSDK
//
//  Created by oceanMAC on 2023/6/8.
//

#import "HYExpressAdView.h"

static NSInteger allTime = 61;

@interface HYExpressAdView()

@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger recordIndex;

@end

@implementation HYExpressAdView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.greenColor;
        
        
        self.timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.timeButton.layer.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.8].CGColor;
        self.timeButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 95, 15, 86, 30);
        self.timeButton.layer.borderWidth = 1.0;
        self.timeButton.layer.borderColor = UIColor.whiteColor.CGColor;
        self.timeButton.layer.cornerRadius = 15.0;
        self.timeButton.layer.masksToBounds = YES;
        [self.timeButton setTitle:@"点击跳过" forState:0];
        self.timeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.timeButton setTitleColor:UIColor.whiteColor forState:0];
        [self addSubview:self.timeButton];
        [self.timeButton addTarget:self action:@selector(closeAddButton) forControlEvents:UIControlEventTouchUpInside];
        
        self.timeButton.hidden = YES;
        
//        self.timer = [NSTimer timerWithTimeInterval:(1.0f) target:self selector:@selector(timeRecordCurrent) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
//        [self.timer setFireDate:[NSDate distantFuture]];
    }
    return self;
}

- (void)closeAddButton {
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
            [self.delegate customView:self event:nil];
        }
    }];

}

- (void)timeRecordCurrent {
    
    self.recordIndex--;
    if (self.recordIndex <= 0) {
        [self.timer setFireDate:[NSDate distantFuture]];
        self.timeButton.userInteractionEnabled = YES;
        [self closeAddButton];
        return;
    }
    if (self.recordIndex > 0 && self.recordIndex > 40) {
        self.timeButton.userInteractionEnabled = YES;
        [self.timeButton setTitle:[NSString stringWithFormat:@"%ld%@ 后可跳过",21 - allTime + self.recordIndex,@"s"] forState:0];
        return;
    }
    self.timeButton.userInteractionEnabled = YES;
    [self.timeButton setTitle:[NSString stringWithFormat:@"%ld%@ 点击跳过",self.recordIndex,@"s"] forState:0];
}

- (void)showAd
{
    self.timeButton.hidden = NO;
    self.recordIndex = allTime;
    [self.timer setFireDate:[NSDate date]];
    
    [self bringSubviewToFront:self.timeButton];
}

@end
