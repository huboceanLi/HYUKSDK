//
//  BaseModel.h
//  MYSaSClerk
//
//  Created by chong on 2019/11/16.
//  Copyright © 2019 chong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

@property (nonatomic, strong) NSString * message;   ///<提示信息
@property (nonatomic, strong) NSObject * data;    ///<数据
@property (nonatomic, assign) NSInteger code;     ///<接口错误码

@property (nonatomic, assign) NSInteger statusCode; ///<网络请求错误码

@end

@interface CommonBaseModel : NSObject <NSCopying,NSMutableCopying,NSCoding>

@end
NS_ASSUME_NONNULL_END
