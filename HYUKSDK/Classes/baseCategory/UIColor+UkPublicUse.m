//
//  UIColor+UkPublicUse.m
//  MYSaSClerk
//
//  Created by chong on 2019/11/16.
//  Copyright © 2019 chong. All rights reserved.
//

#import "UIColor+UkPublicUse.h"

@implementation UIColor (UkPublicUse)

+ (UIColor *)mainColor
{
    return [UIColor qmui_colorWithHexString:@"#08CADE"];
}

+ (UIColor *)bgColor {
    return [UIColor qmui_colorWithHexString:@"#f2f2f2"];
}

+(UIColor *)bgColorFF{
    return [UIColor qmui_colorWithHexString:@"#FFFFFF"];
}

+(UIColor *)bgColorFFE{
    return [UIColor qmui_colorWithHexString:@"#FFE4E4"];
}

+(UIColor *)bgColorEB{
    return [UIColor qmui_colorWithHexString:@"#EBEBEB"];
}


#pragma mark-- TextColor

+(UIColor *)textColor22{
    return [UIColor qmui_colorWithHexString:@"#222222"];
}

+(UIColor *)textColor6E{
    return [UIColor qmui_colorWithHexString:@"#6E7580"];
}

///#2796F6
+(UIColor *)textColor27{
    return [UIColor qmui_colorWithHexString:@"#2796F6"];
}

+(UIColor *)textColorCD{
    return [UIColor qmui_colorWithHexString:@"#CD893F"];
}

+(UIColor *)textColor43{
    return [UIColor qmui_colorWithHexString:@"#43A180"];
}

+(UIColor *)textColorD0{
    return [UIColor qmui_colorWithHexString:@"#D08282"];
}


+(UIColor *)textColor30{
    return [UIColor qmui_colorWithHexString:@"#30C77B"];
}

+(UIColor *)textColorA9{
    return [UIColor qmui_colorWithHexString:@"#A9AFB8"];
}

///#515151
+ (UIColor *) textColor51{
    return [UIColor qmui_colorWithHexString:@"#515151"];
}

+ (UIColor *)textColor33 {
    return [UIColor qmui_colorWithHexString:@"#333333"];
}

+ (UIColor *)textColor99 {
    return [UIColor qmui_colorWithHexString:@"#999999"];
}

+ (UIColor *)textColorD3 {
    return [UIColor qmui_colorWithHexString:@"#D3D3D3"];
}

+ (UIColor *)textColorFF {
    return [UIColor qmui_colorWithHexString:@"#FF5050"];
}

+ (UIColor *)textColorFF6 {
    return [UIColor qmui_colorWithHexString:@"#FF6666"];
}

#pragma mark-- GrayColor
+ (UIColor *)grayColorA3 {
    return [UIColor qmui_colorWithHexString:@"#A3AECB"];
}

+ (UIColor *)grayColor6 {
    return [UIColor qmui_colorWithHexString:@"#666666"];
}

#pragma mark-- LineColor
+ (UIColor *)lineColor {
    return [UIColor qmui_colorWithHexString:@"#D9E2E9"];
}

+ (UIColor *)lineColor97 {
    return [UIColor qmui_colorWithHexString:@"#979797"];
}

#pragma mark-- 色彩循环

///#4791FF
+ (UIColor *)circumColor47{
    return [UIColor qmui_colorWithHexString:@"#4791FF"];
}
///#FF7C4D
+ (UIColor *)circumColorFF7C{
    return [UIColor qmui_colorWithHexString:@"#FF7C4D"];
}
///#FFAD42
+ (UIColor *)circumColorFFA{
    return [UIColor qmui_colorWithHexString:@"#FFAD42"];
}
///#8080FF
+ (UIColor *)circumColor80{
    return [UIColor qmui_colorWithHexString:@"#8080FF"];
}
///#30C77B
+ (UIColor *)circumColor30{
    return [UIColor qmui_colorWithHexString:@"#30C77B"];
}
///#26ADF0
+ (UIColor *)circumColor26{
    return [UIColor qmui_colorWithHexString:@"#26ADF0"];
}
///#FF7070
+ (UIColor *)circumColorFF70{
    return [UIColor qmui_colorWithHexString:@"#FF7070"];
}

@end
