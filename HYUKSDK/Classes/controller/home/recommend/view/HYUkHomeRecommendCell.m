//
//  HYUkHomeRecommendCell.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

#import "HYUkHomeRecommendCell.h"
#import "HYUkRecommendListView.h"

@interface HYUkHomeRecommendCell()<HYBaseViewDelegate>

@property (nonatomic, strong) HYUkRecommendListView *listView;

@end

@implementation HYUkHomeRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;

        self.listView = [HYUkRecommendListView new];
        self.listView.delegate = self;
        [self.contentView addSubview:self.listView];
        
        [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    if ([self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:event];
    }
}

- (void)loadContent {
    self.listView.data = self.data;
    [self.listView loadContent];
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
