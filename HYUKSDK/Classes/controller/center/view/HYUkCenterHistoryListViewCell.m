//
//  HYUkCenterHistoryListViewCell.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/4.
//

#import "HYUkCenterHistoryListViewCell.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkCenterHistoryListViewCell()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *timeLab;

@end

@implementation HYUkCenterHistoryListViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        self.headImageView = [UIImageView new];
        self.headImageView.layer.cornerRadius = 6.0;
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3].CGColor;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.headImageView];
        
        self.timeLab = [UILabel new];
        self.timeLab.text = @"59:59";
        self.timeLab.font = [UIFont systemFontOfSize:11];
        self.timeLab.textAlignment = NSTextAlignmentRight;
        self.timeLab.textColor = [UIColor whiteColor];
        [self addSubview:self.timeLab];

        self.name = [UILabel new];
        self.name.font = [UIFont systemFontOfSize:12];
        self.name.numberOfLines = 2;
        self.name.textColor = [UIColor textColor22];
        [self addSubview:self.name];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(54);
        }];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.headImageView.mas_bottom).offset(6);
            make.height.lessThanOrEqualTo(@(32));
        }];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-4);
            make.bottom.equalTo(self.headImageView);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)loadContent {
    HYUkHistoryRecordModel *recordModel = self.data;
    
    self.name.text = recordModel.name;
    [self.headImageView setImageWithURL:[NSURL URLWithString:recordModel.imageUrl] placeholder:[UIImage uk_bundleImage:@"uk_image_fail"]];
    self.timeLab.text = [[HYUkConfigManager sharedInstance] changeTimeWithDuration:recordModel.playDuration];
}

@end
