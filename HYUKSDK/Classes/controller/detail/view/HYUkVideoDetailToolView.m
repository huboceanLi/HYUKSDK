//
//  HYUkVideoDetailToolView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYUkVideoDetailToolView.h"

@interface HYUkVideoDetailToolView()

//@property (nonatomic, strong) QMUIButton *changeBtn;
@property (nonatomic, strong) QMUIButton *downBtn;
@property (nonatomic, strong) QMUIButton *likeBtn;
@property (nonatomic, strong) QMUIButton *shareBtn;

@end

@implementation HYUkVideoDetailToolView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
//    self.changeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
//    [self.changeBtn setTitle:@"换源" forState:0];
//    [self.changeBtn setTitleColor:UIColor.textColor22 forState:0];
//    self.changeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [self.changeBtn setImage:[UIImage uk_bundleImage:@"qiehuanyonghu"] forState:0];
//    [self.changeBtn setImagePosition:QMUIButtonImagePositionTop];
//    self.changeBtn.spacingBetweenImageAndTitle = 10;
//    self.changeBtn.tag = 1;
//    [self addSubview:self.changeBtn];
//    [self.changeBtn addTarget:self action:@selector(changeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.downBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.downBtn setTitle:@"下载" forState:0];
    [self.downBtn setTitleColor:UIColor.textColor22 forState:0];
    self.downBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.downBtn setImage:[UIImage uk_bundleImage:@"xiazai"] forState:0];
    [self.downBtn setImagePosition:QMUIButtonImagePositionTop];
    self.downBtn.spacingBetweenImageAndTitle = 10;
    self.downBtn.tag = 2;
    [self addSubview:self.downBtn];
    [self.downBtn addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.likeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setTitle:@"收藏" forState:0];
    [self.likeBtn setTitleColor:UIColor.textColor22 forState:0];
    self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.likeBtn setImage:[UIImage uk_bundleImage:@"shoucang"] forState:0];
    [self.likeBtn setImagePosition:QMUIButtonImagePositionTop];
    self.likeBtn.spacingBetweenImageAndTitle = 10;
    self.likeBtn.tag = 3;
    [self addSubview:self.likeBtn];
    [self.likeBtn addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setTitle:@"分享" forState:0];
    [self.shareBtn setTitleColor:UIColor.textColor22 forState:0];
    self.shareBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.shareBtn setImage:[UIImage uk_bundleImage:@"fenxiang"] forState:0];
    [self.shareBtn setImagePosition:QMUIButtonImagePositionTop];
    self.shareBtn.spacingBetweenImageAndTitle = 10;
    self.shareBtn.tag = 4;
    [self addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat w = 60;
    CGFloat space = (SCREEN_WIDTH - w * 3) / 4;
    
//    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(space);
//        make.width.mas_offset(w);
//        make.centerY.equalTo(self);
//    }];
    
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(space);
        make.width.mas_offset(w);
        make.centerY.equalTo(self);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downBtn.mas_right).offset(space);
        make.width.mas_offset(w);
        make.centerY.equalTo(self);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeBtn.mas_right).offset(space);
        make.width.mas_offset(w);
        make.centerY.equalTo(self);
    }];
}

//- (void)changeButtonClick {
//    
//}

- (void)downButtonClick {
    
}

- (void)likeButtonClick {
    
}

- (void)shareButtonClick {
    
}
@end
