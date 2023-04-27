//
//  HYUkSearchViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkSearchViewController.h"
#import "HYUkSearchHeadView.h"

@interface HYUkSearchViewController ()<HYBaseViewDelegate>

@property (nonatomic, strong) HYUkSearchHeadView *searchHeadView;

@end

@implementation HYUkSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.whiteColor;
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    [self.navBackButton setImage:[UIImage uk_bundleImage:@"31fanhui1"] forState:0];
    
    [self.navBar addSubview:self.searchHeadView];
    [self.searchHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navBackButton.mas_right).offset(0);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.right.equalTo(self.navBar.mas_right).offset(0);
        make.height.mas_equalTo(40);
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
