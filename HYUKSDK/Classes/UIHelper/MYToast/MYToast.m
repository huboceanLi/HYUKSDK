//
//  MYToast.m
//  MYERP
//
//  Created by chong on 2020/3/13.
//  Copyright © 2020 iMac. All rights reserved.
//

#import "MYToast.h"

@implementation MYToast

+ (void)showWithText:(NSString *)text {
    [self showWithText:text inView:DefaultTipsParentView];
}

+ (void)showWithText:(NSString *)text inView:(UIView *)view {
    [self showWithText:text inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (void)showWithText:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    QMUITips *tips = [QMUITips createTipsToView:view];
    tips.userInteractionEnabled = NO;
    tips.toastPosition = QMUIToastViewPositionBottom;
    QMUIToastContentView *contentView = (QMUIToastContentView *)tips.contentView;
    contentView.minimumSize = CGSizeMake(120, 36);
    contentView.insets = UIEdgeInsetsMake(8, 25, 10, 25);
    NSMutableDictionary * attributed = contentView.textLabelAttributes.mutableCopy;
    attributed[NSFontAttributeName] = UIFontMake(14);
    contentView.textLabelAttributes = attributed;

    tips.offset = CGPointMake(0, -40);
    [tips showWithText:text hideAfterDelay:delay];
}
@end
