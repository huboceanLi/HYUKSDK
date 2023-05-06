//
//  APIBaseManager.h
//  FaceStore
//
//  Created by 王博 on 2019/3/6.
//  Copyright © 2019年 cdhnf. All rights reserved.
//
#import "Target_FaceStoreService.h"
#import <YYKit/YYKit.h>

typedef void (^RequestSuccessed)(NSString * message, id responseObject);
typedef void (^RequestFailure)(CTAPIManagerErrorType errorType, NSString * errorMessage);

@interface APIBaseManager : CTAPIBaseManager

//Get
+ (NSInteger)getLoadDataWithAPI:(NSString *)apiName params:(NSDictionary *)params modelName:(NSString *)modelName success:(RequestSuccessed)successCallback fail:(RequestFailure)failCallback;
+ (NSInteger)getLoadDataWithAPI:(NSString *)apiName params:(NSDictionary *)params modelName:(NSString *)modelName isShowLoading:(BOOL)isShowLoading success:(RequestSuccessed)successCallback fail:(RequestFailure)failCallback;
//Post
+ (NSInteger)postLoadDataWithAPI:(NSString *)apiName params:(NSDictionary *)params modelName:(NSString *)modelName success:(RequestSuccessed)successCallback fail:(RequestFailure)failCallback;
+ (NSInteger)postLoadDataWithAPI:(NSString *)apiName params:(NSDictionary *)params modelName:(NSString *)modelName isShowLoading:(BOOL)isShowLoading success:(RequestSuccessed)successCallback fail:(RequestFailure)failCallback;
//delete
+ (NSInteger)deleteLoadDataWithAPI:(NSString *)apiName params:(NSDictionary *)params modelName:(NSString *)modelName success:(RequestSuccessed)successCallback fail:(RequestFailure)failCallback;
//PUT
+ (NSInteger)putLoadDataWithAPI:(NSString *)apiName params:(NSDictionary *)params modelName:(NSString *)modelName success:(RequestSuccessed)successCallback fail:(RequestFailure)failCallback;

//loadData
+ (NSInteger)loadDataWithParams:(NSDictionary *)params modelName:(NSString *)modelName success:(RequestSuccessed)successCallback fail:(RequestFailure)failCallback;
+ (NSInteger)loadDataWithParams:(NSDictionary *)params modelName:(NSString *)modelName isShowLoading:(BOOL)isShowLoading success:(RequestSuccessed)successCallback fail:(RequestFailure)failCallback;




/**
 0=成功
 500=服务器内部异常
 401=未授权
 403=拒绝访问，没有权限
 10001={0}不能为空
 10002=数据库中已存在该记录
 10003=获取参数失败
 10004=账号或密码错误
 10005=账号已被停用
 10006=唯一标识不能为空
 10007=验证码不正确
 10008=先删除子菜单或按钮
 10009=原密码不正确
 10010=账号不存在
 10011=上级部门选择错误
 10012=上级菜单不能为自身
 10013=数据权限接口，只能是Map类型参数
 10014=请先删除下级部门
 10015=请先删除部门下的用户
 10016=参数格式不正确，请使用JSON格式
 10017=上级区域选择错误
 10018=请先删除下级区域
 */
@end

