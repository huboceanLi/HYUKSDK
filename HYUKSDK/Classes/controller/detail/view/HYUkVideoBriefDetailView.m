//
//  HYUkVideoBriefDetailView.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYUkVideoBriefDetailView.h"

@interface HYUkVideoBriefDetailView()

@property(nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *des;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UILabel *briefLab;

@end

@implementation HYUkVideoBriefDetailView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage uk_bundleImage:@"guanbi"] forState:0];
    [self addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.width.height.mas_equalTo(@(50));
    }];
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:18];
    self.name.textColor = UIColor.textColor22;
    self.name.text = @"测试";
    [self addSubview:self.name];

    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(@(50));
        make.width.lessThanOrEqualTo(@(SCREEN_WIDTH - 80));
    }];

    self.scrollView = [UIScrollView new];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, IS_iPhoneX ? 44 : 20, 0);
    [self addSubview:self.scrollView];
    if (@available(iOS 11.0, *)) {
        [self.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(50);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(self.mas_height);
    }];

    self.des = [UILabel new];
    self.des.font = [UIFont systemFontOfSize:13];
    self.des.numberOfLines = 0;
    self.des.text = @"未来属于青年，希望寄予青年。长期以来，习近平总书记始终关心青年成长成才、谋划青年工作发展进步。言之谆谆、期望殷殷，激励着广大青年不负时代、不负韶华，在青春的赛道上奋力奔跑。";
    self.des.textColor = UIColor.textColor99;
    [self.scrollView addSubview:self.des];

    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.scrollView.mas_top).offset(10);
        make.width.mas_equalTo(@(SCREEN_WIDTH - 32));
    }];

    UIView *lines = [UIView new];
    lines.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.2];
    [self.scrollView addSubview:lines];

    [lines mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.des.mas_bottom).offset(0);
        make.height.mas_offset(0.5);
        make.width.mas_equalTo(@(SCREEN_WIDTH - 32));

    }];

    self.tipLab = [UILabel new];
    self.tipLab.font = [UIFont boldSystemFontOfSize:18];
    self.tipLab.text = @"简介";
    self.tipLab.textColor = UIColor.textColor22;
    [self.scrollView addSubview:self.tipLab];

    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(lines.mas_bottom).offset(20);
        make.height.mas_offset(20);
    }];

    self.briefLab = [UILabel new];
    self.briefLab.font = [UIFont systemFontOfSize:13];
    self.briefLab.numberOfLines = 0;
    self.briefLab.text = @"在中国人民大学的图书馆里，有一张特殊的老照片，照片里的青年们一张张神采飞扬的面孔，讲述着一段青春故事。";
    self.briefLab.textColor = UIColor.textColor99;
    [self.scrollView addSubview:self.briefLab];

    [self.briefLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.tipLab.mas_bottom).offset(20);
        make.width.mas_equalTo(@(SCREEN_WIDTH - 32));
        make.bottom.equalTo(self.scrollView.mas_bottom).offset(-(IS_iPhoneX ? 44 : 20));
    }];
}

- (NSAttributedString *)getFirstChapterString:(NSString *)chapterStr
{
    NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:chapterStr];
    textAttributed.font = [UIFont systemFontOfSize:13];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [textAttributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textAttributed length])];
    [textAttributed addAttribute:NSForegroundColorAttributeName value:[UIColor textColor99] range:NSMakeRange(0,[textAttributed length])];

    return textAttributed;
}

- (void)closeButtonClick {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:nil];
    }
}
- (void)loadContent
{
    HYUkVideoDetailModel *model = self.data;
    self.name.text = model.vod_name;
    
    NSString *scoreStr = @"";
    if (model.vod_douban_score.length > 0) {
        scoreStr = [NSString stringWithFormat:@"评分: %@\n",model.vod_douban_score];
    }
    
    NSString *director = @"";
    if (model.vod_director.length > 0) {
        director = [NSString stringWithFormat:@"导演: %@\n",model.vod_director];
    }
    
    NSString *actor = @"";
    if (model.vod_actor.length > 0) {
        actor = [NSString stringWithFormat:@"主演: %@\n",model.vod_actor];
    }
    NSString *s = [NSString stringWithFormat:@"%@\n%@%@类型: %@\n地区: %@\n年代: %@\n",scoreStr,director,actor,model.vod_class,model.vod_area,model.vod_year];

    self.des.attributedText = [self getFirstChapterString:s];

    NSString *content = model.vod_content;
    content = [content stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"</p>" withString:@""];

    if (content.length > 0) {
        self.briefLab.attributedText = [self getFirstChapterString:content];
    }else {
        self.briefLab.attributedText = [self getFirstChapterString:@"无"];
    }
}

@end
