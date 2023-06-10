//
//  HYExpressAdView.h
//  HYUKADSDK
//
//  Created by oceanMAC on 2023/6/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HYExpressAdView;

@protocol HYExpressAdViewDelegate <NSObject>

@optional

- (void)customView:(HYExpressAdView *)view event:(id)event;

@end

@interface HYExpressAdView : UIView

- (void)showAd;
@property (nonatomic, weak) id <HYExpressAdViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
