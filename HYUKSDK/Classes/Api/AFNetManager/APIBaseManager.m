//
//  APIBaseManager.m
//  FaceStore
//
//  Created by 王博 on 2019/3/6.
//  Copyright © 2019年 cdhnf. All rights reserved.
//

#import "APIBaseManager.h"
#import "BaseModel.h"
//#import "AppDelegate+Change.h"

@interface APIBaseManager ()<CTAPIManagerValidator,CTAPIManager>

@property (class, nonatomic, copy) NSString * apiName;
@property (class, nonatomic, assign) CTAPIManagerRequestType requestType;


@end

@implementation APIBaseManager

static NSString * _apiName = nil;
static CTAPIManagerRequestType _requestType = 0;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}
#pragma mark--Setter、Getter
+ (NSString *)apiName
{
    if (!_apiName) {
        _apiName = [[NSString alloc] init];
    }
    return _apiName;
}

+ (void)setApiName:(NSString *)apiName
{
    if (apiName != _apiName) {
        _apiName = apiName;
    }
}

+ (CTAPIManagerRequestType)requestType
{
    return _requestType;
}

+ (void)setRequestType:(CTAPIManagerRequestType)requestType
{
    _requestType = requestType;
}

+ (NSInteger)getLoadDataWithAPI:(NSString *)apiName
                         params:(NSDictionary *)params
                      modelName:(NSString *)modelName
                        success:(RequestSuccessed)successCallback
                           fail:(RequestFailure)failCallback
{
    return [self getLoadDataWithAPI:apiName params:params modelName:modelName isShowLoading:YES success:successCallback fail:failCallback];
}

+ (NSInteger)postLoadDataWithAPI:(NSString *)apiName
                          params:(NSDictionary *)params
                       modelName:(NSString *)modelName
                         success:(RequestSuccessed)successCallback
                            fail:(RequestFailure)failCallback
{
    return [self postLoadDataWithAPI:apiName params:params modelName:modelName isShowLoading:YES success:successCallback fail:failCallback];
}

+ (NSInteger)deleteLoadDataWithAPI:(NSString *)apiName
                            params:(NSDictionary *)params
                         modelName:(NSString *)modelName
                           success:(RequestSuccessed)successCallback
                              fail:(RequestFailure)failCallback
{
    APIBaseManager.requestType = CTAPIManagerRequestTypeDelete;
    APIBaseManager.apiName = apiName;
    return [self loadDataWithParams:params modelName:modelName isShowLoading:YES success:successCallback fail:failCallback];
}

+ (NSInteger)putLoadDataWithAPI:(NSString *)apiName params:(NSDictionary *)params modelName:(NSString *)modelName success:(RequestSuccessed)successCallback fail:(RequestFailure)failCallback
{
    APIBaseManager.requestType = CTAPIManagerRequestTypePut;
    APIBaseManager.apiName = apiName;
    return [self loadDataWithParams:params modelName:modelName isShowLoading:NO success:successCallback fail:failCallback];
}

+ (NSInteger)getLoadDataWithAPI:(NSString *)apiName
                         params:(NSDictionary *)params
                      modelName:(NSString *)modelName
                  isShowLoading:(BOOL)isShowLoading
                        success:(RequestSuccessed)successCallback
                           fail:(RequestFailure)failCallback
{
    APIBaseManager.requestType = CTAPIManagerRequestTypeGet;
    APIBaseManager.apiName = apiName;
    return [self loadDataWithParams:params modelName:modelName isShowLoading:isShowLoading success:successCallback fail:failCallback];
}

+ (NSInteger)postLoadDataWithAPI:(NSString *)apiName
                          params:(NSDictionary *)params
                       modelName:(NSString *)modelName
                   isShowLoading:(BOOL)isShowLoading
                         success:(RequestSuccessed)successCallback
                            fail:(RequestFailure)failCallback
{
    APIBaseManager.requestType = CTAPIManagerRequestTypePost;
    APIBaseManager.apiName = apiName;
    return [self loadDataWithParams:params modelName:modelName isShowLoading:isShowLoading success:successCallback fail:failCallback];
}

+ (NSInteger)loadDataWithParams:(NSDictionary *)params
                      modelName:(NSString *)modelName
                        success:(RequestSuccessed)successCallback
                           fail:(RequestFailure)failCallback
{
    return [self loadDataWithParams:params modelName:modelName isShowLoading:YES success:successCallback fail:failCallback];
}

+ (NSInteger)loadDataWithParams:(NSDictionary *)params
                      modelName:(NSString *)modelName
                  isShowLoading:(BOOL)isShowLoading
                        success:(RequestSuccessed)successCallback
                           fail:(RequestFailure)failCallback
{
    if (isShowLoading) {
//        SHOW_HUD(nil);
//        [SVProgressHUD show];
    }
    return [self loadDataWithParams:params success:^(CTAPIBaseManager * _Nonnull apiManager) {
        
        if (isShowLoading) {
//            HIDE_HUD;
        }
                                                                                 
        id fetchedRawData;
        if (apiManager.response.content) {
            fetchedRawData = [apiManager.response.content copy];
        }else{
            fetchedRawData = [apiManager.response.responseData copy];
        }
        if (modelName) {
            BaseModel * baseModel;
            if ([fetchedRawData isKindOfClass:[NSDictionary class]]) {
                baseModel = [BaseModel modelWithDictionary:fetchedRawData];
            }
            
            if ([fetchedRawData isKindOfClass:[NSString class]]) {
                baseModel = [BaseModel modelWithJSON:fetchedRawData];
            }
            //若需要状态码可在此处理
//            if (baseModel.status == 200) {
//
//            }
            NSObject * dataModel = baseModel.data;
            if (modelName.length > 0 && [NSClassFromString(modelName) isSubclassOfClass:[CommonBaseModel class]]) {
                if ([dataModel isKindOfClass:[NSArray class]]) {
                    dataModel = [NSArray modelArrayWithClass:NSClassFromString(modelName) json:dataModel];
                } else if ([dataModel isKindOfClass:[NSDictionary class]]) {
                    dataModel = [NSClassFromString(modelName) modelWithDictionary:(NSDictionary *)dataModel];
                } else if ([dataModel isKindOfClass:[NSString class]]) {
                    dataModel = [NSClassFromString(modelName) modelWithJSON:dataModel];
                }
            }
            
            successCallback(baseModel.message, dataModel);
        }else{
            successCallback(@"请求成功",fetchedRawData);
        }
    } fail:^(CTAPIBaseManager * _Nonnull apiManager) {
        if (isShowLoading) {
//            HIDE_HUD;
        }
        
        NSString * errorMessage = apiManager.errorMessage;
        id fetchedRawData;
        if (apiManager.response.content) {
            fetchedRawData = [apiManager.response.content copy];
        }else{
            fetchedRawData = [apiManager.response.responseData copy];
        }
        
        BaseModel * baseModel = [BaseModel modelWithDictionary:fetchedRawData];
        //自定义错误码-9999代表BaseModel模型转换失败
//        if (baseModel.status != -9999) {
//            failCallback(apiManager.errorType, baseModel.message);
//            return;
//        }
        
        switch (baseModel.code) {
//            case 500:{
//                failCallback(apiManager.errorType, baseModel.msg);
//                return;
//            }
//                break;
            case 20006:{
                //Token失效
//                [APPDELEGATE presentToLoginWithErrorMessage:baseModel.message];
            }
                break;
            case 999:{
                //系统维护
//                errorMessage = @"系统正在升级中，暂停使用，预计2小时，请稍后再试！";
//                [APPDELEGATE presentToSystemUpgradeWebViewController];
            }
                break;
            default:
                break;
        }
        
        
        if (baseModel.message) {
            failCallback(apiManager.errorType,baseModel.message);
        } else {
            failCallback(apiManager.errorType,errorMessage);
        }

    }];
    
}

#pragma mark--<CTAPIManager>
- (NSString *)methodName
{
    return APIBaseManager.apiName;
}

- (NSString *)serviceIdentifier
{
    return FaceStoreServiceIdentifier;
}

- (CTAPIManagerRequestType)requestType
{
    return APIBaseManager.requestType;
}

#pragma mark - CTAPIManagerValidator
- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    BaseModel * baseModel = [BaseModel modelWithDictionary:data];
    if (baseModel.code == 1) {
        return CTAPIManagerErrorTypeNoError;
    } else if (baseModel.code == -9999) {
        //请求接口不是baseModel版本
        return CTAPIManagerErrorTypeNoError;
    }
    
//    BaseOldModel * oldModel = [BaseOldModel modelWithDictionary:data];
//    if (oldModel.success) {
//        return CTAPIManagerErrorTypeNoError;
//    }
    
    return CTAPIManagerErrorTypeNoContent;
}
@end