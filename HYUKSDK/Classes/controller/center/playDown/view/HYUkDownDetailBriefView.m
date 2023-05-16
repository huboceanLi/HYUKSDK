//
//  HYUkDownDetailBriefView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/16.
//

#import "HYUkDownDetailBriefView.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkDownDetailBriefView()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *des;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UILabel *briefLab;

@end

@implementation HYUkDownDetailBriefView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.name = [UILabel new];
    self.name.font = [UIFont boldSystemFontOfSize:18];
    self.name.textColor = UIColor.textColor22;
    [self addSubview:self.name];

    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(@(50));
        make.width.lessThanOrEqualTo(@(SCREEN_WIDTH - 80));
    }];
    
    self.des = [UILabel new];
    self.des.font = [UIFont systemFontOfSize:13];
    self.des.numberOfLines = 0;
    self.des.textColor = UIColor.textColor99;
    [self addSubview:self.des];

    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.name.mas_bottom).offset(-10);
        make.width.mas_equalTo(@(SCREEN_WIDTH - 32));
    }];
    
    UIView *lines = [UIView new];
    lines.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.2];
    [self addSubview:lines];

    [lines mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.des.mas_bottom).offset(12);
        make.height.mas_offset(0.5);
        make.width.mas_equalTo(@(SCREEN_WIDTH - 32));

    }];

    self.tipLab = [UILabel new];
    self.tipLab.font = [UIFont boldSystemFontOfSize:18];
    self.tipLab.text = @"简介";
    self.tipLab.textColor = UIColor.textColor22;
    [self addSubview:self.tipLab];

    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(lines.mas_bottom).offset(16);
        make.height.mas_offset(20);
    }];

    self.briefLab = [UILabel new];
    self.briefLab.font = [UIFont systemFontOfSize:13];
    self.briefLab.numberOfLines = 0;
    self.briefLab.textColor = UIColor.textColor99;
    [self addSubview:self.briefLab];

    [self.briefLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.tipLab.mas_bottom).offset(20);
        make.width.mas_equalTo(@(SCREEN_WIDTH - 32));
        make.bottom.equalTo(self.mas_bottom).offset(-(IS_iPhoneX ? 44 : 20));
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

- (void)loadContent
{
    HYUkDownListModel *model = self.data;
    self.name.text = [NSString stringWithFormat:@"%@ %@",model.vod_name,model.playName];

    
    NSString *str = @"";
    if (model.type_id_1 == 1) {
        str = @"电影";
    }else if (model.type_id_1 == 2) {
        str = @"电视剧";
    }else if (model.type_id_1 == 3) {
        str = @"综艺";
    }else if (model.type_id_1 == 4) {
        str = @"动漫";
    }else if (model.type_id_1 == 24) {
        str = @"记录片";
    }else {
        str = @"其他";
    }
    NSString *s = [NSString stringWithFormat:@"%@/%@/%@",model.vod_year,str,model.vod_area];

    self.des.attributedText = [self getFirstChapterString:s];

    NSString *content = model.content;
    content = [content stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"</p>" withString:@""];

    if (content.length > 0) {
        self.briefLab.attributedText = [self getFirstChapterString:content];
    }else {
        self.briefLab.attributedText = [self getFirstChapterString:@"无"];
    }
}

@end
