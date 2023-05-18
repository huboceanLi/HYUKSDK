//
//  HYUkLinkViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/18.
//

#import "HYUkLinkViewController.h"
#import "HYUkRequestWorking.h"

@interface HYUkLinkViewController ()

@property (nonatomic, strong) HYVideoVersionModel *versionModel;

@end

@implementation HYUkLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
    [HYUkRequestWorking getVersionCompletionHandle:^(HYVideoVersionModel * _Nonnull model, BOOL success) {
        if (success) {
            weakSelf.versionModel = model;
        }
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
