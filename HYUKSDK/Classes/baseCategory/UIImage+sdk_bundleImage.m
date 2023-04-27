//
//  UIImage+sdk_bundleImage.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/3/31.
//

#import "UIImage+sdk_bundleImage.h"

@implementation UIImage (sdk_bundleImage)

+ (UIImage *)sdk_bundleImage:(NSString *)imageName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"HYVideoSDK" withExtension:@"bundle"];
        
    return [UIImage imageNamed:imageName inBundle:[NSBundle bundleWithURL:url] compatibleWithTraitCollection:nil];
}

@end
