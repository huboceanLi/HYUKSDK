//
//  HYUKLinkViewController.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUKLinkViewController : UIViewController

//- (void)showViewControllerRootVC:(void (^)(BOOL rootVC))rootVC;

@property (copy, nonatomic) void (^successBlock)(BOOL rootVC);

@end

NS_ASSUME_NONNULL_END
