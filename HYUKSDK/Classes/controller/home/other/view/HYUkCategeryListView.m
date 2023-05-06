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
    

    

    
    self.areaView.data = @[@"全部",@"大陆",@"香港",@"美国",@"英国",@"西班牙"];
    [self.areaView loadContent];
    
    self.langView.data = @[@"全部",@"国语",@"粤语",@"英语",@"土耳其语"];
    [self.langView loadContent];
    

}
- (void)loadContent {
    HYResponseCategeryModel *model = self.data;
    
    self.scoreView.data = model.order;
    [self.scoreView loadContent];
    
    if (model.type.count > 0) {
        NSMutableArray *typeArr = [NSMutableArray array];
        [typeArr insertObject:@"全部" atIndex:0];
        for (HYResponseCategeryTypeModel *item in model.type) {
            [typeArr addObject:item.name];
        }
        self.typeView.data = typeArr;
        [self.typeView loadContent];
        self.typeView.hidden = NO;
        [self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
    }else {
        self.typeView.hidden = YES;
        [self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    if (model.vod_year.count > 0) {
        NSMutableArray *yearArr = [model.vod_year mutableCopy];
        [yearArr insertObject:@"全部" atIndex:0];
        self.yearView.data = yearArr;
        [self.yearView loadContent];
        
        self.yearView.hidden = NO;
        [self.yearView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
    }else {
        self.yearView.hidden = YES;
        [self.yearView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
}

@end
