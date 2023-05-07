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
@property (nonatomic, assign) NSInteger index;

@end

@implementation HYUkCategeryListView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;
    self.index = 0;
    
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
}

- (void)loadContent {
    HYResponseCategeryModel *model = self.data;
    
    self.scoreView.data = model.order;
    [self.scoreView loadContent];
    self.index++;
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
        self.index++;
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
        self.index++;
    }else {
        self.yearView.hidden = YES;
        [self.yearView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    if (model.vod_area.count > 0) {
        NSMutableArray *areaArr = [model.vod_area mutableCopy];
        [areaArr insertObject:@"全部" atIndex:0];
        self.areaView.data = areaArr;
        [self.areaView loadContent];
        
        self.areaView.hidden = NO;
        [self.areaView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
        self.index++;
    }else {
        self.areaView.hidden = YES;
        [self.areaView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    if (model.vod_lang.count > 0) {
        NSMutableArray *langArr = [model.vod_lang mutableCopy];
        [langArr insertObject:@"全部" atIndex:0];
        self.langView.data = langArr;
        [self.langView loadContent];
        
        self.langView.hidden = NO;
        [self.langView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
        self.index++;
    }else {
        self.langView.hidden = YES;
        [self.langView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:[NSString stringWithFormat:@"%ld",self.index]];
    }
}

@end
