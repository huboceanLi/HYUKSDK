//
//  HYUkSettingCell.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import "HYUkSettingCell.h"

@interface HYUkSettingCell()



@end

@implementation HYUkSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;

        
        self.headImageView = [UIImageView new];
//        self.headImageView.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.headImageView];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(16);
            make.width.height.mas_equalTo(24);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.name = [UILabel new];
        self.name.text = @"是的是大的是丰收";
        self.name.font = [UIFont systemFontOfSize:16];
        self.name.textColor = [UIColor textColor22];
        [self.contentView addSubview:self.name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-100);
            make.centerY.equalTo(self.contentView);
        }];

        self.arrowImageView = [UIImageView new];
        self.arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.arrowImageView.image = [UIImage uk_bundleImage:@"jinrujiantou"];
        [self.contentView addSubview:self.arrowImageView];
        
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.width.height.mas_equalTo(14);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.playSwitch = [[UISwitch alloc] init];
        self.playSwitch.transform = CGAffineTransformMakeScale(0.7, 0.7);
        [self.contentView addSubview:self.playSwitch];
        [self.playSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.briefLab = [UILabel new];
        self.briefLab.text = @"就拉上倒海课程";
        self.briefLab.font = [UIFont systemFontOfSize:12];
        self.briefLab.textAlignment = NSTextAlignmentRight;
        self.briefLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.briefLab];

        [self.briefLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView.mas_left).offset(-2);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
        [self.contentView addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
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
