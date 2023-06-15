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
        self.headImageView.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
        self.headImageView.image = [UIImage uk_bundleImage:@"uk_image_loading"];
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.headImageView];
        
        self.name = [UILabel new];
        self.name.font = [UIFont systemFontOfSize:XJFlexibleFont(13)];
        self.name.textColor = [UIColor textColor22];
        [self addSubview:self.name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_offset(20);
        }];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self.name.mas_top).offset(-XJFlexibleFont(6));
        }];
        
        self.des = [UILabel new];
        self.des.font = [UIFont boldSystemFontOfSize:10];
        self.des.textAlignment = NSTextAlignmentCenter;
        self.des.textColor = [UIColor whiteColor];
        [self.headImageView addSubview:self.des];
        self.des.layer.backgroundColor = [[UIColor textColor22] colorWithAlphaComponent:0.5].CGColor;
        
        [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.headImageView);
            make.height.mas_offset(16);
        }];
        
        self.scoreLab = [UILabel new];
        self.scoreLab.font = [UIFont fontWithName:@"AmericanTypewriter" size:16];
        self.scoreLab.textColor = [UIColor whiteColor];
        [self.headImageView addSubview:self.scoreLab];
//        self.des.layer.backgroundColor = [[UIColor textColor22] colorWithAlphaComponent:0.5].CGColor;
        
        [self.scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_left).offset(8);
            make.top.equalTo(self.headImageView.mas_top).offset(8);
        }];
    }
    return self;
}

- (void)loadContent {
//    HYMovieListItemModel *model = self.data;
//
//    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholder:nil];
//    self.name.text = model.name;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
