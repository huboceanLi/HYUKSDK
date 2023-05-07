//
//  HYUkCategeryListView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkCategeryListView.h"
#import "HYUkHomeCategeryView.h"

@interface HYUkCategeryListView()<HYBaseViewDelegate>

@property (nonatomic, strong) HYUkHomeCategeryView *scoreView;
@property (nonatomic, strong) HYUkHomeCategeryView *typeView;
@property (nonatomic, strong) HYUkHomeCategeryView *areaView;
@property (nonatomic, strong) HYUkHomeCategeryView *langView;
@property (nonatomic, strong) HYUkHomeCategeryView *yearView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *typeModels;


@end

@implementation HYUkCategeryListView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.clearColor;
    self.index = 0;

    self.tempCategaryModel = [HYUkTempCategaryModel new];
    self.tempCategaryModel.type_id = -1;
    self.tempCategaryModel.vod_area = @"";
    self.tempCategaryModel.vod_lang = @"";
    self.tempCategaryModel.vod_year = @"";
    self.tempCategaryModel.order = @"最新";

    self.scoreView = [HYUkHomeCategeryView new];
    self.scoreView.delegate = self;
    self.scoreView.tag = 1;
    [self addSubview:self.scoreView];
    
    [self.scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];

    self.typeView = [HYUkHomeCategeryView new];
    self.typeView.delegate = self;
    self.typeView.tag = 2;
    [self addSubview:self.typeView];
    
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.scoreView.mas_bottom).offset(0);
    }];
    
    self.areaView = [HYUkHomeCategeryView new];
    self.areaView.delegate = self;
    self.areaView.tag = 3;
    [self addSubview:self.areaView];
    
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.typeView.mas_bottom).offset(0);
    }];
    
    self.langView = [HYUkHomeCategeryView new];
    self.langView.delegate = self;
    self.langView.tag = 4;
    [self addSubview:self.langView];
    
    [self.langView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.areaView.mas_bottom).offset(0);
    }];
    
    self.yearView = [HYUkHomeCategeryView new];
    self.yearView.delegate = self;
    self.yearView.tag = 5;
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
        self.typeModels = model.type;
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
        [self.delegate customView:self event:@{@"type":@"h",@"h":[NSString stringWithFormat:@"%ld",self.index]}];
    }
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    NSString *str = event;
    
    NSInteger index = view.tag;
    if (index == 1) {
        self.tempCategaryModel.order = event;
    }else if (index == 2) {
        if ([str isEqualToString:@"全部"]) {
            self.tempCategaryModel.type_id = -1;
        }else {
            for (HYResponseCategeryTypeModel *item in self.typeModels) {
                if ([str isEqualToString:item.name]) {
                    self.tempCategaryModel.type_id = item.ID;
                    break;
                }
            }
        }

    }else if (index == 3) {
        if ([str isEqualToString:@"全部"]) {
            self.tempCategaryModel.vod_area = @"";
        }else {
            self.tempCategaryModel.vod_area = event;
        }

    }else if (index == 4) {
        if ([str isEqualToString:@"全部"]) {
            self.tempCategaryModel.vod_lang = @"";
        }else {
            self.tempCategaryModel.vod_lang = event;
        }

    }else if (index == 5) {
        if ([str isEqualToString:@"全部"]) {
            self.tempCategaryModel.vod_year = @"";
        }else {
            self.tempCategaryModel.vod_year = event;
        }
    };
    
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@{@"type":@"r",@"h":@""}];
    }
}

@end
