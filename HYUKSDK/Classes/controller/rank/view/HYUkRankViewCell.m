//
//  HYUkRankViewCell.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkRankViewCell.h"

@interface HYUkRankViewCell()

@property (nonatomic, strong) UIView *coverView;



@end

@implementation HYUkRankViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;
        
        self.coverView = [UIView new];
        self.coverView.backgroundColor = UIColor.whiteColor;
        self.coverView.layer.cornerRadius = IS_IPAD ? 18.0 : 12.0;
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
        self.headImageView.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.coverView addSubview:self.headImageView];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.coverView.mas_left).offset(12);
            make.width.mas_equalTo(XJFlexibleFont(80));
            make.bottom.equalTo(self.coverView.mas_bottom).offset(-10);
            make.top.equalTo(self.coverView.mas_top).offset(10);
        }];
        
        self.name = [UILabel new];
        self.name.font = [UIFont boldSystemFontOfSize:XJFlexibleFont(16)];
        self.name.textColor = [UIColor textColor22];
        [self.coverView addSubview:self.name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(14);
            make.right.equalTo(self.coverView.mas_right).offset(-12);
            make.top.equalTo(self.coverView.mas_top).offset(12);
        }];
        
        self.typeLab = [UILabel new];
        self.typeLab.font = [UIFont systemFontOfSize:XJFlexibleFont(12)];
        self.typeLab.textColor = [UIColor lightGrayColor];
        [self.coverView addSubview:self.typeLab];
        
        [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.coverView.mas_right).offset(-12);
            make.top.equalTo(self.name.mas_bottom).offset(XJFlexibleFont(8));
        }];
        
        self.briefLab = [UILabel new];
        self.briefLab.font = [UIFont systemFontOfSize:XJFlexibleFont(12)];
        self.briefLab.numberOfLines = 0;
        self.briefLab.textColor = [UIColor lightGrayColor];
        [self.coverView addSubview:self.briefLab];

        
        self.tagView = [HYUkRankClassView new];
        self.tagView.backgroundColor = UIColor.clearColor;
        [self.coverView addSubview:self.tagView];
        
        [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.coverView.mas_right).offset(-12);
            make.bottom.equalTo(self.coverView.mas_bottom).offset(-14);
            make.height.mas_equalTo(XJFlexibleFont(20));
        }];
        
        [self.briefLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.coverView.mas_right).offset(-12);
            make.top.equalTo(self.typeLab.mas_bottom).offset(0);
            make.bottom.equalTo(self.tagView.mas_top).offset(IS_IPAD ? -12 : 0);
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
