//
//  BadgeButton.m
//  MYSaas
//
//  Created by vic on 2020/10/29.
//  Copyright © 2020 chong. All rights reserved.
//

#import "BadgeButton.h"
#import <HYBaseTool/HYBaseTool.h>

@interface BadgeButton()

@property (nonatomic, strong) UILabel *badgeLabel;

@property (nonatomic, assign) UIEdgeInsets  insets;

@property (nonatomic, assign) CGFloat   badgeRadius;

@end

@implementation BadgeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setNormalTitleColor:[UIColor textColor33]];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        _insets = UIEdgeInsetsMake(5, 0, 0, 5);
    }
    return self;
}


#pragma mark -public

-(void)setImage:(UIImage *)img title:(NSString *)title{
    [self setNormalImage:img];
    [self setNormalTitle:title];
    [self updateLayout];
}


-(void)setFont:(UIFont *)font{
    [self.titleLabel setFont:font];
    [self updateLayout];
}

- (void)setBadgeStr:(NSString *)badgeStr
{
    _badgeStr = badgeStr;
    NSInteger c = [badgeStr integerValue];
    if (c > 99) {
        self.badgeLabel.hidden = false;
        [self.badgeLabel setText:@"99+"];
    } else if (c > 0) {
        self.badgeLabel.hidden = false;
//            [self.badgeLabel setText:@"分享"];

        [self.badgeLabel setText:badgeStr];
    } else {
        self.badgeLabel.hidden = true;
        [self.badgeLabel setText:@""];
    }
    [self updateLayout];

    
}
//-(void)setBadge:(NSInteger)badge{
//    _badge = badge;
//
//}

-(void)setBadgeInset:(UIEdgeInsets)insets{
    _insets = insets;
    [self updateLayout];
}

#pragma makr- lazy

-(UILabel *)badgeLabel{
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc]init];
        _badgeLabel.layer.cornerRadius= self.badgeRadius;
//        _badgeLabel.layer.borderWidth = 0.5;
        _badgeLabel.layer.backgroundColor = [UIColor redColor].CGColor;
//        _badgeLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.font = [UIFont systemFontOfSize:11];
        _badgeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_badgeLabel];
    }
    return _badgeLabel;
}

-(CGFloat)badgeRadius {
    if (!_badgeRadius){
        _badgeRadius = 8.0f;
    }
    return _badgeRadius;
}

#pragma mark -private

-(void) updateLayout {
    UIImageView *imageView = self.imageView;
    UILabel *titleLabel = self.titleLabel;
    
    if (titleLabel.text.length && imageView.image.size.width) {
        //只有同时设置了title和image才需要调整 UIEdgeInsets
        float  spacing = 10;//图片和文字的上下间距
        CGSize imageSize = imageView.frame.size;
        CGSize titleSize = titleLabel.frame.size;
        CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : titleLabel.font}];
        CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
        if (titleSize.width + 0.5 < frameSize.width) {
            titleSize.width = frameSize.width;
        }
        CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
        self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    } else {
        //重置 UIEdgeInsets
        self.imageEdgeInsets = UIEdgeInsetsZero;
        self.titleEdgeInsets = UIEdgeInsetsZero;
    }
    CGFloat padding = 0.5f; //badgeLabel的内边距
    CGFloat top = _insets.top - _insets.bottom;    //badgeLabel基于基点的在上下方向的调整  +向下移动
    CGFloat trailing = _insets.right - _insets.left; //badgeLabel基于基点的左右方向的调整 +向左移动
    CGFloat badgeHeight = self.badgeRadius * 2;

    NSInteger c = [self.badgeStr integerValue];
    if (c > 0) {
        self.badgeLabel.font = [UIFont systemFontOfSize:11];

        NSDictionary *badgeAttr = @{NSFontAttributeName: self.badgeLabel.font};
        CGSize size = CGSizeMake(self.bounds.size.width, self.badgeRadius * 2);
        CGSize  badgeSize = [self.badgeLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:badgeAttr context:nil].size;
        
        CGFloat badgeWidth = badgeSize.width + padding < self.badgeRadius * 2 ? self.badgeRadius * 2 : badgeSize.width + padding;
        
        if (imageView.image) {
            self.badgeLabel.frame = CGRectMake(imageView.right - trailing, imageView.top - badgeHeight + top, badgeWidth, badgeHeight); //这是以imageview右上角为基点
//                self.badgeLabel.frame = CGRectMake(imageView.right - trailing, imageView.top - badgeHeight + top, badgeWidth, badgeHeight); //这是以imageview右上角为基点

        } else {
            self.badgeLabel.frame = CGRectMake(self.frame.size.width - badgeWidth/2, top - badgeHeight/2, badgeWidth, badgeHeight); //这是以button右上角为基点
        }
    }

//    if (self.badge) {
//
//    }
}

@end
