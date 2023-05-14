//
//  HYUkDownProgressCell.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import "HYUkDownProgressCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkDownProgressCell()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *sizeLab;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *progressLab;

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIImageView *stopImageView;

@end

@implementation HYUkDownProgressCell

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
        
        self.stopImageView = [UIImageView new];
        self.stopImageView.backgroundColor = UIColor.redColor;
        self.stopImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.headImageView addSubview:self.stopImageView];
        
        [self.stopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.headImageView);
            make.width.height.mas_equalTo(24);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
//            make.top.equalTo(self.contentView.mas_top).offset(12);
        }];
        
        self.name = [UILabel new];
        self.name.text = @"是的是大的是丰收";
        self.name.font = [UIFont boldSystemFontOfSize:16];
        self.name.textColor = [UIColor textColor22];
        [self.contentView addSubview:self.name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.contentView.mas_top).offset(14);
        }];

        self.coverView = [UIView new];
        self.coverView.layer.cornerRadius = 2.0;
        self.coverView.layer.masksToBounds = YES;
        self.coverView.clipsToBounds = YES;
        self.coverView.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.2];
        [self.contentView addSubview:self.coverView];
        
        [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(13);
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.height.mas_equalTo(4);
        }];
        
        self.progressView = [UIView new];
        self.progressView.backgroundColor = UIColor.mainColor;
        [self.coverView addSubview:self.progressView];
        
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.coverView);
            make.width.mas_equalTo(50);
        }];
        
        self.sizeLab = [UILabel new];
        self.sizeLab.text = @"599.7M";
        self.sizeLab.font = [UIFont systemFontOfSize:12];
        self.sizeLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.sizeLab];

        
        [self.sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coverView.mas_bottom).offset(13);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.height.mas_equalTo(16);
        }];
        
        self.progressLab = [UILabel new];
        self.progressLab.text = @"下载中...";
        self.progressLab.textAlignment = NSTextAlignmentRight;
        self.progressLab.font = [UIFont systemFontOfSize:12];
        self.progressLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.progressLab];
        
        [self.progressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coverView.mas_bottom).offset(13);
            make.left.equalTo(self.headImageView.mas_right).offset(12);
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
    HYUkDownListModel *model = self.data;

    self.name.text = [NSString stringWithFormat:@"%@ %@",model.vod_name,model.playName];
    [self.headImageView setImageWithURL:[NSURL URLWithString:model.vod_pic] placeholder:[UIImage uk_bundleImage:@"uk_image_fail"]];
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
