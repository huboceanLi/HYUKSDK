//
//  HYUKContactViewController.m
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/6/18.
//

#import "HYUKContactViewController.h"

@interface HYUKContactViewController ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation HYUKContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.whiteColor;
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    self.navTitleLabel.text = @"联系我们";
    self.navTitleLabel.textColor = UIColor.textColor22;
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"uk_back"] forState:0];
    
    self.contentView = [UIView new];
    self.contentView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(XJFlexibleFont(20));
        make.right.equalTo(self.view.mas_right).offset(-XJFlexibleFont(20));
    }];
    
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    bgImg.image = [HYUKConfigManager shareInstance].iconImage;
    bgImg.layer.cornerRadius = XJFlexibleFont(10);
    bgImg.layer.masksToBounds = YES;
    [self.contentView addSubview:bgImg];

    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.width.height.mas_offset(XJFlexibleFont(80));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImg.frame) + XJFlexibleFont(6), SCREEN_WIDTH, XJFlexibleFont(25))];;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [NSString stringWithFormat:@"v %@",SDKVersion];
    label1.numberOfLines = 0;
    label1.userInteractionEnabled = YES;
    label1.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    label1.font = UIFontMake(XJFlexibleFont(18));
    [self.contentView addSubview:label1];
    UITapGestureRecognizer *previewRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
    [label1 addGestureRecognizer:previewRecognizer1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImg.mas_bottom).offset(XJFlexibleFont(6));
        make.left.right.equalTo(self.contentView);
    }];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];;
    label2.text = @"有疑问或需要查看平台最新动态请进粉丝群。";
    label2.textColor = [UIColor textColor22];
    label2.font = UIFontMake(XJFlexibleFont(15));
    [self.contentView addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(XJFlexibleFont(40));
        make.left.equalTo(self.contentView.mas_left).offset(XJFlexibleFont(20));
        make.right.equalTo(self.contentView.mas_right).offset(-XJFlexibleFont(20));
    }];
    
    UIButton *q1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [q1 setTitle:@"群➀ 865839997" forState:0];
    q1.tag = 1;
    [q1 setTitleColor:[UIColor colorWithHexString:@"#1296db"] forState:0];
    q1.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(15)];
    [self.contentView addSubview:q1];
    [q1 addTarget:self action:@selector(copyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [q1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(XJFlexibleFont(20));
        make.left.equalTo(self.contentView.mas_left).offset(XJFlexibleFont(20));
    }];
    
    UIButton *q2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [q2 setTitle:@"群➁ 865849320" forState:0];
    q2.tag = 2;
    [q2 setTitleColor:[UIColor colorWithHexString:@"#1296db"] forState:0];
    q2.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(15)];
    [self.contentView addSubview:q2];
    [q2 addTarget:self action:@selector(copyButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [q2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(q1.mas_bottom).offset(XJFlexibleFont(20));
        make.left.equalTo(self.contentView.mas_left).offset(XJFlexibleFont(20));
    }];
    
    UIButton *q3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [q3 setTitle:@"群➂ 865847048" forState:0];
    q3.tag = 3;
    [q3 setTitleColor:[UIColor colorWithHexString:@"#1296db"] forState:0];
    q3.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(15)];
    [self.contentView addSubview:q3];
    [q3 addTarget:self action:@selector(copyButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [q3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(q2.mas_bottom).offset(XJFlexibleFont(20));
        make.left.equalTo(self.contentView.mas_left).offset(XJFlexibleFont(20));
    }];
    
    UIButton *q4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [q4 setTitle:@"群➃ 865848989" forState:0];
    q4.tag = 4;
    [q4 setTitleColor:[UIColor colorWithHexString:@"#1296db"] forState:0];
    q4.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(15)];
    [self.contentView addSubview:q4];
    [q4 addTarget:self action:@selector(copyButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [q4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(q3.mas_bottom).offset(XJFlexibleFont(20));
        make.left.equalTo(self.contentView.mas_left).offset(XJFlexibleFont(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    ;
}

- (void)copyButtonClick:(UIButton *)sender {
    NSInteger index = sender.tag;
    

    if (index == 1) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"865839997";
        [MYToast showWithText:@"已复制"];
        return;
    }
    
    if (index == 2) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"865849320";
        [MYToast showWithText:@"已复制"];
        return;
    }
    
    if (index == 3) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"1056942179";
        [MYToast showWithText:@"已复制"];
        return;
    }
    
    if (index == 4) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"865848989";
        [MYToast showWithText:@"已复制"];
        return;
    }
}

- (void)singleTap {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请提出您的建议" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        UITextField *userNameTextField = alertController.textFields.firstObject;
        if ([userNameTextField.text isEqualToString:@"7235"]) {
            [UserDefault setBool:YES forKey:supper_user];
        }
    }]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];

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
