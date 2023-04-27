//
//  HYUkCategeryListView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkCategeryListView.h"
#import "HYUkHomeCategeryView.h"

@interface HYUkCategeryListView()

@property (nonatomic, strong) HYUkHomeCategeryView *scoreView;
@property (nonatomic, strong) HYUkHomeCategeryView *typeView;
@property (nonatomic, strong) HYUkHomeCategeryView *areaView;
@property (nonatomic, strong) HYUkHomeCategeryView *langView;
@property (nonatomic, strong) HYUkHomeCategeryView *yearView;

@end

@implementation HYUkCategeryListView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;
    
    self.scoreView = [HYUkHomeCategeryView new];
    [self addSubview:self.scoreView];
    
    [self.scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];

    self.typeView = [HYUkHomeCategeryView new];
    [self addSubview:self.typeView];
    
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.scoreView.mas_bottom).offset(0);
    }];
    
    self.areaView = [HYUkHomeCategeryView new];
    [self addSubview:self.areaView];
    
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.typeView.mas_bottom).offset(0);
    }];
    
    self.langView = [HYUkHomeCategeryView new];
    [self addSubview:self.langView];
    
    [self.langView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.areaView.mas_bottom).offset(0);
    }];
    
    self.yearView = [HYUkHomeCategeryView new];
    [self addSubview:self.yearView];
    
    [self.yearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.langView.mas_bottom).offset(0);
    }];
    
    self.scoreView.data = @[@"最新",@"最热",@"好评"];
    [self.scoreView loadContent];
    
    self.typeView.data = @[@"全部",@"动作",@"悬疑",@"科幻",@"爱情"];
    [self.typeView loadContent];
    
    self.areaView.data = @[@"全部",@"大陆",@"香港",@"美国",@"英国",@"西班牙"];
    [self.areaView loadContent];
    
    self.langView.data = @[@"全部",@"国语",@"粤语",@"英语",@"土耳其语"];
    [self.langView loadContent];
    
    self.yearView.data = @[@"全部",@"2023",@"2022",@"2021",@"2020",@"2019",@"2018",@"2017",@"更早"];
    [self.yearView loadContent];
}

@end
