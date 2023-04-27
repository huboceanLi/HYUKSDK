//
//  HYVideoUpgradeViewController.m
//  CocoaAsyncSocket
//
//  Created by oceanMAC on 2023/4/6.
//

#import "HYVideoUpgradeViewController.h"
#import "HYVideoUpgradeView.h"

@interface HYVideoUpgradeViewController ()

@property (nonatomic, strong) HYVideoUpgradeView *upgradeView;

@end

@implementation HYVideoUpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.modal = YES;
    self.animationStyle = QMUIModalPresentationAnimationStyleFade;

}

- (void)initSubViews {
    [super initSubViews];
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH - 140, 400)];
    contentView.backgroundColor = UIColor.clearColor;
    self.contentView = contentView;
    
    self.upgradeView = [HYVideoUpgradeView new];
    [self.contentView addSubview:self.upgradeView];
    contentView.height = [self.upgradeView contentViewHeight];
    self.upgradeView.frame = self.contentView.bounds;

}






@end
