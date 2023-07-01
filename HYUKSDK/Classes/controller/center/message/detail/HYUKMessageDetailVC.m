//
//  HYUKMessageDetailVC.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/6/30.
//

#import "HYUKMessageDetailVC.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

static NSString *patternString = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";

@interface HYUKMessageDetailVC()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) YYLabel *contentLab;

@end

@implementation HYUKMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.backgroundColor = UIColor.whiteColor;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    self.navTitleLabel.text = self.noticeItemModel.title;
    self.navTitleLabel.textColor = UIColor.textColor22;
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"uk_back"] forState:0];
    
    self.scrollView = [UIScrollView new];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0, *)) {
        [self.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(IS_iPhoneX ? 80 : 50));
    }];
    
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont boldSystemFontOfSize:XJFlexibleFont(16)];
    self.titleLab.textColor = [UIColor textColor22];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.text = self.noticeItemModel.title;
    [self.scrollView addSubview:self.titleLab];

    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.scrollView.mas_top).offset(XJFlexibleFont(30));
    }];
    
    self.timeLab = [UILabel new];
    self.timeLab.font = [UIFont systemFontOfSize:XJFlexibleFont(12)];
    self.timeLab.textAlignment = NSTextAlignmentCenter;
    self.timeLab.textColor = [UIColor textColor99];
    self.timeLab.text = self.noticeItemModel.created_time_text;
    [self.scrollView addSubview:self.timeLab];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.titleLab.mas_bottom).offset(XJFlexibleFont(16));
    }];

    self.contentLab = [YYLabel new];
    self.contentLab.font = [UIFont systemFontOfSize:XJFlexibleFont(15)];
    self.contentLab.textColor = [UIColor textColor99];
    self.contentLab.numberOfLines = 110;
    [self.scrollView addSubview:self.contentLab];
    
    NSAttributedString *att = [self decodeWithPlainStr:self.noticeItemModel.remark];
    
    self.contentLab.attributedText = att;
    
    CGFloat h = [att boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - XJFlexibleFont(40), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(XJFlexibleFont(20));
        make.right.equalTo(self.view.mas_right).offset(-XJFlexibleFont(20));
        make.top.equalTo(self.timeLab.mas_bottom).offset(XJFlexibleFont(20));
        make.height.mas_equalTo(ceilf(h) + 20);
    }];
    
    [[HYUKNoticeListLogic share] markIsReadWithID:self.noticeItemModel.ID complete:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notice_isRead object:nil];
    }];
}

- (NSMutableAttributedString *)decodeWithPlainStr:(NSString *)plainStr {
    if (!plainStr) {return [[NSMutableAttributedString alloc]initWithString:@""];}
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:plainStr];
    attStr.yy_lineSpacing = 6;
    attStr.yy_font = [UIFont systemFontOfSize:XJFlexibleFont(15)];
    
    NSArray *urlArr = [self getURLFromStr:plainStr patternString:patternString];
    NSMutableArray *newArr = [NSMutableArray array];
    newArr = [urlArr mutableCopy];
    for (NSInteger i = newArr.count-1; i >= 0; i--) {
        NSString *str = newArr[i];
        if (str.length < 2) {
            [newArr removeObjectAtIndex:i];
            continue;
        }
        if ([[str substringToIndex:2] isEqualToString:@"/:"]) {
            [newArr removeObjectAtIndex:i];
            continue;
        }
    }
    if (newArr.count > 0) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSString *str in newArr) {
            if ([tmpArr containsObject:str]) {
                continue;
            }
            NSArray *rangeArr = [self getNewURLFromStr:plainStr patternString:patternString];
            for (NSTextCheckingResult *match in rangeArr) {
                NSRange range = match.range;
                   
                [attStr yy_setTextHighlightRange:range//设置点击的位置
                                                color:[UIColor mainColor]
                                      backgroundColor:[UIColor clearColor]
                                            tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                    NSString *url = [text.string substringWithRange:range];

//                    [containerView routerWithEventName:@"test" userInfo:@{@"url":url, @"id":itemKey}];
                }];
                [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:XJFlexibleFont(15)]} range:range];
            }
            [tmpArr addObject:str];
        }
    }
    
    
    return attStr;
}

- (NSArray <NSTextCheckingResult *>*)getNewURLFromStr:(NSString *)string patternString:(NSString *)patternString {
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patternString
    options:NSRegularExpressionCaseInsensitive
    error:&error];

    NSArray *arrayOfAllMatches = [regex matchesInString:string
    options:0
    range:NSMakeRange(0, [string length])];
    return arrayOfAllMatches;
}

- (NSArray*)getURLFromStr:(NSString *)string patternString:(NSString *)patternString {
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patternString
    options:NSRegularExpressionCaseInsensitive
    error:&error];

    NSArray *arrayOfAllMatches = [regex matchesInString:string
    options:0
    range:NSMakeRange(0, [string length])];

    //NSString *subStr;
    NSMutableArray *arr=[[NSMutableArray alloc] init];

    for (NSTextCheckingResult *match in arrayOfAllMatches){
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        
        substringForMatch = [self getSubstring:string range:match.range substringForMatch:substringForMatch];
        [arr addObject:substringForMatch];
    }
    return arr;
}

- (NSString *)getSubstring:(NSString *)string range:(NSRange)range substringForMatch:(NSString *)substringForMatch{
    
    NSRange subRange = [string rangeOfString:substringForMatch];
    if (subRange.location > 0 && subRange.length > 0) {
        NSString *headString = [string substringToIndex:subRange.location];
        
        NSString *format = @"https://";
        if ([[headString lowercaseString] hasSuffix: format]) {
            
            NSString *str = [headString substringFromIndex:headString.length - format.length];
            return [str stringByAppendingString:substringForMatch];
        }
        
        format = @"http://";
        if ([[headString lowercaseString] hasSuffix: format]) {
            NSString *str = [headString substringFromIndex:headString.length - format.length];
            return [str stringByAppendingString:substringForMatch];
        }
    }
    
    return substringForMatch;
}

@end
