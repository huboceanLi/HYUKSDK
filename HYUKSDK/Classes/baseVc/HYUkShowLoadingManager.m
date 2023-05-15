//
//  HYUkShowLoadingManager.m
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/5.
//

#import "HYUkShowLoadingManager.h"
#import "DGActivityIndicatorView.h"
#import "HYUkHeader.h"

static HYUkShowLoadingManager * manager = nil;

@interface HYUkShowLoadingManager()

@property (nonatomic, strong) DGActivityIndicatorView *activityIndicatorView;

@end

@implementation HYUkShowLoadingManager

+ (HYUkShowLoadingManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)showLoading:(CGFloat)oy
{
    if (!self.activityIndicatorView) {
        self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor mainColor]];
        CGFloat width = SCREEN_WIDTH / 5.0f;
        
        UIView *v = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        if (oy <= -1) {
            self.activityIndicatorView.frame = CGRectMake((v.frame.size.width - width)/2, (v.frame.size.height - width)/2, width, width);
        }else {
            self.activityIndicatorView.frame = CGRectMake((v.frame.size.width - width)/2, oy, width, width);
        }
        [v addSubview:self.activityIndicatorView];
//        [self.activityIndicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.height.mas_equalTo(width);
//            make.centerY.equalTo(v);
//            make.left.equalTo(baseView.mas_left).offset((SCREEN_WIDTH - width)/2.0);
//        }];
//        [self.activityIndicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.mas_equalTo(60);
//            make.center.equalTo(baseView);
//        }];
    }
    /**
     *  开始动画
     */
    [self.activityIndicatorView startAnimating];
}

- (void)removeLoading
{
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    self.activityIndicatorView = nil;
}

@end
