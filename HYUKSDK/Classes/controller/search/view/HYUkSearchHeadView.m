//
//  HYUkSearchHeadView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/26.
//

#import "HYUkSearchHeadView.h"

@interface HYUkSearchHeadView()<QMUITextFieldDelegate>

@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIView *searchContentView;
@property (nonatomic, assign) BOOL isBack;

@end

@implementation HYUkSearchHeadView

- (void)initSubviews {
    [super initSubviews];
    self.backgroundColor = UIColor.clearColor;
    self.isBack = YES;
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn setTitle:@"取消" forState:0];
    [self.searchBtn setTitleColor:UIColor.textColor99 forState:0];
    self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.searchBtn];
    
    self.searchContentView = [UIView new];
    self.searchContentView.layer.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.2].CGColor;
    self.searchContentView.layer.cornerRadius = 16.0;
    self.searchContentView.layer.masksToBounds = YES;
    [self addSubview:self.searchContentView];
    
    UIImageView *searchImageView = [UIImageView new];
    searchImageView.image = [UIImage uk_bundleImage:@"sousuo1"];
    [self.searchContentView addSubview:searchImageView];
    
    
    self.textField = [QMUITextField new];
    self.textField.placeholder = @"请输入关键词";
    self.textField.text = @"狂飙";
    self.textField.delegate = self;
    self.textField.placeholderColor = UIColor.lightGrayColor;
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.textColor = UIColor.textColor33;
    [self.searchContentView addSubview:self.textField];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self);
        make.width.mas_equalTo(60);
    }];
    
    [self.searchContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.searchBtn.mas_left);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(32);
    }];
    
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchContentView.mas_left).offset(10);
        make.centerY.equalTo(self.searchContentView);
        make.height.width.mas_equalTo(20);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.searchContentView);
        make.left.equalTo(searchImageView.mas_right).offset(8);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.searchBtn blockEvent:^(UIButton *button) {
        NSString *toString = [weakSelf.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        if (toString.length > 0) {
            weakSelf.isBack = NO;
            [weakSelf.textField resignFirstResponder];
            [weakSelf startSearch:toString];
        }
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSString *toString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if (toString.length > 0) {
        self.isBack = NO;
        [textField resignFirstResponder];
        [self startSearch:toString];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    toString = [toString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (toString.length > 0) {
        [self.searchBtn setTitle:@"搜索" forState:0];
        [self.searchBtn setTitleColor:UIColor.mainColor forState:0];
        self.isBack = NO;
    }else {
        [self.searchBtn setTitle:@"取消" forState:0];
        [self.searchBtn setTitleColor:UIColor.textColor99 forState:0];
        self.isBack = YES;
    }
    return YES;
}

- (void)startSearch:(NSString *)key {
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@{@"isBack":@(self.isBack),@"key":key}];
    }
}
@end
