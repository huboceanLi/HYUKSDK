//
//  HYUkSearchHeadView.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/26.
//

#import <HYBaseTool/HYBaseTool.h>
#import "HYUkHeader.h"

NS_ASSUME_NONNULL_BEGIN

//typedef NS_ENUM(NSUInteger, SearchStatus) {
//    editing = 0,       //
//    isBack ,    //
//    isSearch,
//};

@interface HYUkSearchHeadView : HYBaseView

@property (nonatomic, strong) QMUITextField *textField;
@property (nonatomic, strong) UIButton *searchBtn;

@end

NS_ASSUME_NONNULL_END
