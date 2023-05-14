//
//  HYUkDownCompleteCell.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/5.
//

#import "HYUkDownCompleteCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkDownCompleteCell()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *briefLab;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *completeLab;

@end

@implementation HYUkDownCompleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;

        
        self.headImageView = [UIImageView new];
        self.headImageView.layer.cornerRadius = 6.0;
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.backgroundColor = UIColor.lightGrayColor;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.headImageView];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(16);
            make.width.mas_equalTo(90);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
            make.top.equalTo(self.contentView.mas_top).offset(12);
        }];
        
        self.name = [UILabel new];
        self.name.font = [UIFont boldSystemFontOfSize:16];
        self.name.textColor = [UIColor textColor22];
        [self.contentView addSubview:self.name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.contentView.mas_top).offset(14);
        }];

        self.briefLab = [UILabel new];
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
        
        self.completeLab = [UILabel new];
        self.completeLab.font = [UIFont systemFontOfSize:12];
        self.completeLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.completeLab];

        
        [self.completeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.briefLab.mas_bottom).offset(5);
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
    self.completeLab.text = @"下载已完成";
    [self.headImageView setImageWithURL:[NSURL URLWithString:model.vod_pic] placeholder:[UIImage uk_bundleImage:@"uk_image_fail"]];

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
    self.briefLab.text = [NSString stringWithFormat:@"%@/%@/%@",model.vod_year,str,model.vod_area];
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
