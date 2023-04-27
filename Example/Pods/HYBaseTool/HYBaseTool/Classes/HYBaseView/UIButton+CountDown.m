//
//  UIButton+CountDown.m
//  MYSaSClerk
//
//  Created by chong on 2019/11/18.
//  Copyright © 2019 chong. All rights reserved.
//

#import "UIButton+CountDown.h"
#import <objc/runtime.h>

static NSString * UIButtonTimer_key = @"timer_key";

@interface UIButton ()

@property(nonatomic, strong) dispatch_source_t timer;

@end

@implementation UIButton (CountDown)

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(self.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitleColor:mColor forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            seconds = seconds % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
//            NSString *timeStr = [NSString stringWithFormat:@"%d分%02d",minute,seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                [self setTitleColor:color forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(self.timer);
}

//停止倒计时
- (void)stopTimeWithTitle:(NSString *)title color:(UIColor *)color {
    dispatch_source_cancel(self.timer);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
    });
}

#pragma mark-- Setter
- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, &UIButtonTimer_key, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark-- Getter
- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, &UIButtonTimer_key);
}
@end
