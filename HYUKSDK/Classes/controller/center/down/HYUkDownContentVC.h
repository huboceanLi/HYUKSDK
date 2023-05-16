//
//  HYUkDownContentVC.h
//  HYUKSDK
//
//  Created by Ocean 李 on 2023/5/14.
//

#import "HYUkBaseListViewController.h"
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUkDownContentVC : HYUkBaseListViewController

@property (nonatomic, assign) NSInteger index;

- (void)deleteData;

@end

NS_ASSUME_NONNULL_END
