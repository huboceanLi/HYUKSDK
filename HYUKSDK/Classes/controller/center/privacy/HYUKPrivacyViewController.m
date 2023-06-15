//
//  HYUKPrivacyViewController.m
//  AFNetworking
//
//  Created by Ocean 李 on 2023/6/15.
//

#import "HYUKPrivacyViewController.h"


@interface HYUKPrivacyViewController ()

@end

@implementation HYUKPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.whiteColor;
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    if (self.index == 1) {
        self.navTitleLabel.text = @"免责申明";
    }else {
        self.navTitleLabel.text = @"隐私政策";
    }
    self.navTitleLabel.textColor = UIColor.textColor22;
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"uk_back"] forState:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shiyongxieyi" ofType:@"txt"];
    NSString *s = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];


    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.font = [UIFont systemFontOfSize:14];
    textView.editable = NO;
    textView.text = s;
    textView.showsVerticalScrollIndicator = NO;
    textView.textColor = [UIColor textColor22];
    textView.alpha = 0.7;
    textView.backgroundColor = [UIColor clearColor];
    [textView setContentInset:UIEdgeInsetsMake(0, 0, -(IS_iPhoneX ? 50 : 16), 0)];
    textView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.top.equalTo(self.navBar.mas_bottom).offset(16);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
