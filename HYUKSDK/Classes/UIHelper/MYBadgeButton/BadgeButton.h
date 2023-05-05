//
//  BadgeButton.h
//  MYSaas
//
//  Created by vic on 2020/10/29.
//  Copyright © 2020 chong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface BadgeButton : UIButton

//@property (nonatomic, assign) NSInteger badge;

@property (nonatomic, strong) NSString *badgeStr;


- (void) setFont:(UIFont *) font;

- (void) setImage:(UIImage*) img title:(NSString*) title;

- (void) setBadgeInset: (UIEdgeInsets) insets; //badge位置调整，有图片则以图片右上角为基点向、没有图片以button的右上为基点

@end

NS_ASSUME_NONNULL_END
