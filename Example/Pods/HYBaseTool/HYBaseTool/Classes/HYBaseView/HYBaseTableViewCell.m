//
//  HYBaseTableViewCell.m
//  AmyNew
//
//  Created by chong on 2018/12/17.
//  Copyright © 2018 chong. All rights reserved.
//

#import "HYBaseTableViewCell.h"

@implementation HYBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initTableViewCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initTableViewCell
{
}

- (void)loadContent {
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 0.f;
}
@end
