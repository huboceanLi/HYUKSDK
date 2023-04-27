//
//  UIColor+PublicUse.h
//  MYSaSClerk
//
//  Created by chong on 2019/11/16.
//  Copyright © 2019 chong. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (PublicUse)

/*
 * 主题色 1EB89C
 */
+ (UIColor *)mainColor;

/// 背景色 #F5F6FA
+ (UIColor *)bgColor;

///#FF6A6A
+ (UIColor *)bgColorFF;

///##FFE4E4
+ (UIColor *)bgColorFFE;

///##EBEBEB
+ (UIColor *)bgColorEB;

#pragma mark-- 文本颜色


///次级文字信息 #6E7580
+ (UIColor *) textColor6E;

///辅助文字信息 #A9AFB8
+ (UIColor *) textColorA9;

///#515151
+ (UIColor *) textColor51;

///#2796F6
+(UIColor *)textColor27;

///#CD893F
+(UIColor *)textColorCD;

///#43A180
+(UIColor *)textColor43;

///#D08282
+(UIColor *)textColorD0;

/// #30C77B
+(UIColor *)textColor30;

/// #222222
+ (UIColor *)textColor22;

/// #333333
+ (UIColor *)textColor33;

/// #999999
+ (UIColor *)textColor99;

/// #E6515D
+ (UIColor *)textColorE6;

///#FF5050
+ (UIColor *) textColorFF;

///#FF6666
+ (UIColor *) textColorFF6;


#pragma mark-- GrayColor
+ (UIColor *)grayColorA3;
+ (UIColor *)grayColor6;

#pragma mark-- lineColor

///#D9E2E9
+ (UIColor *)lineColor;

///#979797
+ (UIColor *)lineColor97;


#pragma mark-- 色彩循环

///#4791FF
+ (UIColor *)circumColor47;
///#FF7C4D
+ (UIColor *)circumColorFF7C;
///#FFAD42
+ (UIColor *)circumColorFFA;
///#8080FF
+ (UIColor *)circumColor80;
///#30C77B
+ (UIColor *)circumColor30;
///#26ADF0
+ (UIColor *)circumColor26;
///#FF7070
+ (UIColor *)circumColorFF70;



@end

NS_ASSUME_NONNULL_END
