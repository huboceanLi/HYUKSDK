//
//  HYUkTextTempModel.m
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/7.
//

#import "HYUkTextTempModel.h"
#import "HYUkHeader.h"

@implementation HYUkTextTempModel

- (CGFloat)nameWidth {
    CGFloat w = [self.name widthForFont:self.nameFont];
    return ceil(w) + 20.0;
}

@end
