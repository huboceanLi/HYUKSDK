//
//  HYUKNoticeTableViewCell.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/6/29.
//

#import "HYUKNoticeTableViewCell.h"

@interface HYUKNoticeTableViewCell()

@property (nonatomic, strong) UIView *converView;
@property (nonatomic, strong) UILabel *topLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *desLab;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *morenLab;


@end

@implementation HYUKNoticeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        self.backgroundColor = UIColor.clearColor;
        
        self.clipsToBounds = YES;

        self.converView = [UIView new];
        self.converView.backgroundColor = UIColor.whiteColor;
        self.converView.layer.cornerRadius = XJFlexibleFont(8);
        self.converView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.converView];
        
        [self.converView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-XJFlexibleFont(16));
            make.left.equalTo(self.contentView.mas_left).offset(XJFlexibleFont(16));
            make.top.bottom.equalTo(self.contentView);
        }];
        
        self.topLab = [UILabel new];
        self.topLab.font = [UIFont systemFontOfSize:XJFlexibleFont(13)];
        self.topLab.textColor = [UIColor mainColor];
        self.topLab.text = @"置顶";
        self.topLab.textAlignment = NSTextAlignmentCenter;
        self.topLab.layer.cornerRadius = XJFlexibleFont(4);
        self.topLab.layer.masksToBounds = YES;
        self.topLab.layer.borderWidth = XJFlexibleFont(1);
        self.topLab.layer.borderColor = [UIColor mainColor].CGColor;
        [self.converView addSubview:self.topLab];
        
        [self.topLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.converView.mas_left).offset(XJFlexibleFont(12));
            make.width.mas_equalTo(XJFlexibleFont(42));
            make.height.mas_equalTo(XJFlexibleFont(20));
            make.top.equalTo(self.converView.mas_top).offset(XJFlexibleFont(10));
        }];
        
        self.titleLab = [UILabel new];
        self.titleLab.font = [UIFont systemFontOfSize:XJFlexibleFont(16)];
        self.titleLab.textColor = [UIColor textColor22];
        self.titleLab.text = @"置顶";
        [self.converView addSubview:self.titleLab];
        

        
        self.timeLab = [UILabel new];
        self.timeLab.font = [UIFont systemFontOfSize:XJFlexibleFont(12)];
        self.timeLab.textAlignment = NSTextAlignmentRight;
        self.timeLab.textColor = [UIColor textColor99];
        self.timeLab.text = @"置顶";
        [self.converView addSubview:self.timeLab];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.converView.mas_right).offset(-XJFlexibleFont(12));
            make.height.mas_equalTo(XJFlexibleFont(40));
            make.top.equalTo(self.converView.mas_top).offset(0);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topLab.mas_right).offset(XJFlexibleFont(12));
            make.right.equalTo(self.timeLab.mas_left).offset(-XJFlexibleFont(12));
            make.height.mas_equalTo(XJFlexibleFont(40));
            make.top.equalTo(self.converView.mas_top).offset(0);
        }];
        
        self.desLab = [UILabel new];
        self.desLab.font = [UIFont systemFontOfSize:XJFlexibleFont(13)];
        self.desLab.textColor = [UIColor textColor99];
        self.desLab.numberOfLines = 2;
        [self.converView addSubview:self.desLab];
        
        [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.converView.mas_left).offset(XJFlexibleFont(12));
            make.right.equalTo(self.converView.mas_right).offset(-XJFlexibleFont(12));
            make.top.equalTo(self.titleLab.mas_bottom).offset(0);
        }];
        
        self.line = [UIView new];
        self.line.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
        [self.converView addSubview:self.line];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.converView);
//            make.right.equalTo(self.contentView.mas_right).offset(-XJFlexibleFont(12));
            make.top.equalTo(self.desLab.mas_bottom).offset(XJFlexibleFont(12));
            make.height.mas_equalTo(XJFlexibleFont(1));
        }];
        
        self.morenLab = [UILabel new];
        self.morenLab.font = [UIFont systemFontOfSize:XJFlexibleFont(15)];
        self.morenLab.textColor = [UIColor mainColor];
        self.morenLab.textAlignment = NSTextAlignmentCenter;
        self.morenLab.text = @"查看详情";
        [self.converView addSubview:self.morenLab];
        
        [self.morenLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.converView.mas_left).offset(XJFlexibleFont(12));
            make.right.equalTo(self.converView.mas_right).offset(-XJFlexibleFont(12));
            make.top.equalTo(self.line.mas_bottom).offset(0);
            make.height.mas_equalTo(XJFlexibleFont(40));
            make.bottom.equalTo(self.converView.mas_bottom).offset(0);
        }];
    }
    return self;
}

- (void)loadContent {
    HYUKResponseNoticeItemModel *model = self.data;
    self.titleLab.text = model.title;
    self.desLab.text = model.remark;
    self.timeLab.text = model.created_time_text;

    if (model.top_switch) {
        [self.topLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.converView.mas_left).offset(XJFlexibleFont(12));
            make.width.mas_equalTo(XJFlexibleFont(42));
        }];
    }else {
        [self.topLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.converView.mas_left).offset(0);
            make.width.mas_equalTo(0);
        }];
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
