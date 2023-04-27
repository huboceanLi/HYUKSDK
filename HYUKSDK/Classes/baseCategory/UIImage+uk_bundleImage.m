//
//  UIImage+uk_bundleImage.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/3/31.
//

#import "UIImage+uk_bundleImage.h"

@implementation UIImage (uk_bundleImage)

+ (UIImage *)uk_bundleImage:(NSString *)imageName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"HYVideoSDK" withExtension:@"bundle"];
        
    return [UIImage imageNamed:imageName inBundle:[NSBundle bundleWithURL:url] compatibleWithTraitCollection:nil];
}

@end
