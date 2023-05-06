//
//  HYUkOtherViewController.h
//  HYUKSDK
//
//  Created by oceanMAC on 2023/4/27.
//

#import "HYUkBaseListViewController.h"
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYUkOtherViewController : HYUkBaseListViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) HYResponseCategeryModel *categeryModel;


@end

NS_ASSUME_NONNULL_END
