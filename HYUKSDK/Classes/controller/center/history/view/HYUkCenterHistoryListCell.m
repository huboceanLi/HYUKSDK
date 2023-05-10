//
//  HYUkCenterHistoryListCell.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import "HYUkCenterHistoryListCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkCenterHistoryListCell()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *playTimeLab;
@property (nonatomic, strong) UILabel *briefLab;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation HYUkCenterHistoryListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;

        
        self.headImageView = [UIImageView new];
        self.headImageView.layer.cornerRadius = 6.0;
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.headImageView];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(16);
            make.width.mas_equalTo(90);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
            make.top.equalTo(self.contentView.mas_top).offset(12);
        }];
        
        self.playTimeLab = [UILabel new];
        self.playTimeLab.text = @"01:59:59";
        self.playTimeLab.font = [UIFont systemFontOfSize:12];
        self.playTimeLab.textAlignment = NSTextAlignmentRight;
        self.playTimeLab.textColor = [UIColor whiteColor];
        [self.headImageView addSubview:self.playTimeLab];
        
        [self.playTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headImageView.mas_right).offset(-5);
            make.bottom.equalTo(self.headImageView.mas_bottom).offset(-5);
            make.height.mas_equalTo(16);
        }];
        
        self.name = [UILabel new];
        self.name.text = @"是的是大的是丰收";
        self.name.font = [UIFont boldSystemFontOfSize:16];
        self.name.textColor = [UIColor textColor22];
        [self.contentView addSubview:self.name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.contentView.mas_top).offset(20);
        }];

        
        self.briefLab = [UILabel new];
        self.briefLab.text = @"剩余: 01:59:59";
        self.briefLab.font = [UIFont systemFontOfSize:12];
        self.briefLab.numberOfLines = 1;
        self.briefLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.briefLab];

        
        [self.briefLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.name.mas_bottom).offset(5);
            make.height.mas_equalTo(16);
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

- (void)loadContent {
    HYUkHistoryRecordModel *recordModel = self.data;
    self.name.text = recordModel.name;
    [self.headImageView setImageWithURL:[NSURL URLWithString:recordModel.imageUrl] placeholder:[UIImage uk_bundleImage:@"uk_image_fail"]];
    self.playTimeLab.text = [[HYUkConfigManager sharedInstance] changeTimeWithDuration:recordModel.playDuration];
    
    if (recordModel.playDuration < recordModel.duration) {
        self.briefLab.text = [NSString stringWithFormat:@"剩余:%@",[[HYUkConfigManager sharedInstance] changeTimeWithDuration:recordModel.duration - recordModel.playDuration]];
    }else if (recordModel.playDuration == recordModel.duration) {
        self.briefLab.text = @"观看结束";
    }else {
        self.briefLab.text = @"";
    }
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
