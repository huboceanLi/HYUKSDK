//
//  HYUkVideoHomeListCell.m
//  CocoaAsyncSocket
//
//  Created by oceanMAC on 2023/4/10.
//

#import "HYUkVideoHomeListCell.h"

@interface HYUkVideoHomeListCell()



@end

@implementation HYUkVideoHomeListCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        self.headImageView = [UIImageView new];
        self.headImageView.layer.cornerRadius = 6.0;
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.backgroundColor = UIColor.lightGrayColor;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.headImageView];
        
        self.name = [UILabel new];
        self.name.text = @"是的是大的是丰收";
        self.name.font = [UIFont systemFontOfSize:13];
        self.name.textColor = [UIColor textColor22];
        [self addSubview:self.name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_offset(20);
        }];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self.name.mas_top).offset(-6);
        }];
    }
    return self;
}

- (void)loadContent {
//    HYMovieListItemModel *model = self.data;
//
//    [self.headImageView setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholder:nil];
//    self.name.text = model.name;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
