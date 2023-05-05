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

- (void)showLoading:(UIView *)baseView {
    
    if (!self.activityIndicatorView) {
        self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor mainColor]];
        CGFloat width = SCREEN_WIDTH / 5.0f;
        
//        self.activityIndicatorView.frame = CGRectMake((baseView.frame.size.width - width)/2, (baseView.frame.size.height - width)/2, width, height);
        [baseView addSubview:self.activityIndicatorView];
        [self.activityIndicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(width);
            make.centerY.equalTo(baseView);
            make.left.equalTo(baseView.mas_left).offset((SCREEN_WIDTH - width)/2.0);
        }];
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
