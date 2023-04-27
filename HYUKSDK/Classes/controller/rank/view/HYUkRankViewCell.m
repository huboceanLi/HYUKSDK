//
//  HYUkRankViewCell.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkRankViewCell.h"

@interface HYUkRankViewCell()

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UILabel *briefLab;
@property (nonatomic, strong) UIView *tagView;

@end

@implementation HYUkRankViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;
        
        self.coverView = [UIView new];
        self.coverView.backgroundColor = UIColor.whiteColor;
        self.coverView.layer.cornerRadius = 12.0;
        self.coverView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.coverView];
        
        [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        
        self.headImageView = [UIImageView new];
        self.headImageView.layer.cornerRadius = 6.0;
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.backgroundColor = UIColor.lightGrayColor;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.coverView addSubview:self.headImageView];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.coverView.mas_left).offset(12);
            make.width.mas_equalTo(80);
            make.bottom.equalTo(self.coverView.mas_bottom).offset(-10);
            make.top.equalTo(self.coverView.mas_top).offset(10);
        }];
        
        self.name = [UILabel new];
        self.name.text = @"是的是大的是丰收";
        self.name.font = [UIFont boldSystemFontOfSize:16];
        self.name.textColor = [UIColor textColor22];
        [self.coverView addSubview:self.name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(14);
            make.right.equalTo(self.coverView.mas_right).offset(-12);
            make.top.equalTo(self.coverView.mas_top).offset(12);
        }];
        
        self.typeLab = [UILabel new];
        self.typeLab.text = @"逻辑啊各位UI浪费改色个翡翠绿哇哥发的擦根深蒂固客户刚吃完卡看个饭卡的水果茶i阿";
        self.typeLab.font = [UIFont systemFontOfSize:12];
        self.typeLab.textColor = [UIColor lightGrayColor];
        [self.coverView addSubview:self.typeLab];
        
        [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.coverView.mas_right).offset(-12);
            make.top.equalTo(self.name.mas_bottom).offset(8);
        }];
        
        self.briefLab = [UILabel new];
        self.briefLab.text = @"就拉上倒海翻江啦福利二号放假啦扫黄打非i逻辑啊各位UI浪费改色个翡翠绿哇哥发的擦根深蒂固客户刚吃完卡看个饭卡的水果茶i阿里斯顿官方i啊广发卡事故调查卡公司的课程";
        self.briefLab.font = [UIFont systemFontOfSize:12];
        self.briefLab.numberOfLines = 0;
        self.briefLab.textColor = [UIColor lightGrayColor];
        [self.coverView addSubview:self.briefLab];

        
        self.tagView = [UIView new];
        self.tagView.backgroundColor = UIColor.redColor;
        [self.coverView addSubview:self.tagView];
        
        [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.coverView.mas_right).offset(-12);
            make.bottom.equalTo(self.coverView.mas_bottom).offset(-14);
            make.height.mas_equalTo(20);
        }];
        
        [self.briefLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.coverView.mas_right).offset(-12);
            make.top.equalTo(self.typeLab.mas_bottom).offset(0);
            make.bottom.equalTo(self.tagView.mas_top).offset(0);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
