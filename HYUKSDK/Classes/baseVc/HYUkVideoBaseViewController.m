//
//  HYUkVideoBaseViewController.m
//  HYVideoSDK_Example
//
//  Created by oceanMAC on 2023/3/31.
//  Copyright © 2023 admin@buzzmsg.com. All rights reserved.
//

#import "HYUkVideoBaseViewController.h"

@interface HYUkVideoBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation HYUkVideoBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeRotation(0);
        [[UIApplication sharedApplication] setStatusBarHidden:false];
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([self.navigationController.viewControllers count] == 1) {
        return NO;
    }else{
        return YES;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor bgColorFF];
}

#pragma mark 懒加载
-(UIView *)navBar {
    
    if (!_navBar) {
        _navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (IS_iPhoneX?88:64))];
        _navBar.backgroundColor = [UIColor mainColor];
        [self.view addSubview:_navBar];
    }
    return _navBar;
}

-(UILabel *)navTitleLabel {
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, IS_iPhoneX?48:24, SCREEN_WIDTH, 40)];
        _navTitleLabel.textColor = [UIColor bgColorFF];
        _navTitleLabel.font = [UIFont boldSystemFontOfSize:17];
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.navBar addSubview:_navTitleLabel];
    }
    return _navTitleLabel;
}

-(UIButton *)navBackButton {
    if (!_navBackButton) {
        _navBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navBackButton.frame = CGRectMake(0, (IS_iPhoneX?48:24), 40, 40);
        [_navBackButton addTarget:self action:@selector(clickedBackButton:) forControlEvents:UIControlEventTouchUpInside];
        [_navBackButton setImage:[UIImage sdk_bundleImage:@"p_back"] forState:UIControlStateNormal];
        [self.navBar addSubview:_navBackButton];
    }
    return _navBackButton;
}

-(void)clickedBackButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
