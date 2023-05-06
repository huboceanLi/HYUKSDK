//
//  FaceStoreService.m
//  FaceStore
//
//  Created by 王博 on 2019/3/5.
//  Copyright © 2019年 cdhnf. All rights reserved.
//

#import "FaceStoreService.h"
#import "APIString.h"

@interface FaceStoreService ()

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, assign) BOOL isOldURL;    //YES:1.0版本URL NO:新URL
//@property (nonatomic, strong) NSArray * oldInterfaceArray;  //旧接口地址
@property (nonatomic, strong) AFHTTPRequestSerializer * requestSerializer;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer * jsonRequestSerializer;
@property (nonatomic, strong) AFHTTPSessionManager * manager;

@end

@implementation FaceStoreService

@synthesize apiEnvironment = _apiEnvironment;

#pragma mark - public methods
- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(CTAPIManagerRequestType)requestType
{
//    [self checkMethodName:methodName];
    NSString * urlString;
    if ([methodName hasPrefix:@"http"]) {
        urlString = methodName;
    } else if (methodName) {
        urlString = self.baseURL;
        urlString = [urlString stringByAppendingFormat:@"%@%@",
        ([urlString hasSuffix:@"/"] ? @"" : @"/"),     //确保url前缀后面有1个字符'/'
        ([methodName hasPrefix:@"/"] ? [methodName substringFromIndex:1] : methodName)   //确保apiName前面没有字符'/'
        ];
    } else {
        return nil;
    }
    
    //防止urlString中包含特殊字符,导致转NSURL失败
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if (requestType == CTAPIManagerRequestTypeGet) {
        //        NSString *tsString = [NSUUID UUID].UUIDString;
        //        NSString *md5Hash = [[NSString stringWithFormat:@"%@%@%@", tsString, self.privateKey, self.publicKey] CT_MD5];
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET"
                                                                           URLString:urlString
                                                                          parameters:params
                                                                               error:nil];
        return request;
    }else if(requestType == CTAPIManagerRequestTypePost && [params.allKeys containsObject:@"newFile"]){
        NSArray *parameterArr = params[@"newFile"];
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST"
                                                                       URLString:urlString
                                                                      parameters:parameterArr
                                                                           error:nil];
        return request;
    } else if (requestType == CTAPIManagerRequestTypePost) {
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST"
                                                                           URLString:urlString
                                                                          parameters:params
                                                                               error:nil];
        return request;
    }else if (requestType == CTAPIManagerRequestTypeDelete) {
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"DELETE"
                                                                       URLString:urlString
                                                                      parameters:params
                                                                           error:nil];
        return request;
    }else if (requestType == CTAPIManagerRequestTypePut && ([params.allKeys containsObject:@"file"] || [params.allKeys containsObject:@"videofile"])) {
        NSMutableURLRequest * request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            if ([params.allKeys containsObject:@"file"]) {
                NSArray * dataArr = params[@"file"];
                for (NSData *data in dataArr) {
                    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                    // 要解决此问题，
                    // 可以在上传时使用当前的系统事件作为文件名
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    [formatter setDateFormat:@"yyyyMMddHHmmss"];
                    NSString *dateString = [formatter stringFromDate:[NSDate date]];
                    [formData appendPartWithFileData:data name:@"file" fileName:[NSString  stringWithFormat:@"%@.jpg", dateString] mimeType:@"image/jpeg"];
                }
            } else {
                NSArray * dataArr = params[@"videofile"];
                for (NSData *data in dataArr) {
                    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                    // 要解决此问题，
                    // 可以在上传时使用当前的系统事件作为文件名
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    [formatter setDateFormat:@"yyyyMMddHHmmss"];
                    NSString *dateString = [formatter stringFromDate:[NSDate date]];
                    [formData appendPartWithFileData:data name:@"file" fileName:[NSString  stringWithFormat:@"%@.mp4", dateString] mimeType:@"video/mp4"];
                }
            }
            

        } error:nil];

        return request;
    }else if(requestType == CTAPIManagerRequestTypePut){
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"PUT"
                                                                       URLString:urlString
                                                                      parameters:params
                                                                           error:nil];
        return request;
    }
    
    return nil;
}

- (NSDictionary *)resultWithResponseObject:(id)responseObject response:(NSURLResponse *)response request:(NSURLRequest *)request error:(NSError **)error
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
//    if (statusCode == 401) {//401代表token失效，跳转到登录界面
//        [UserDefault removeObjectForKey:TOKEN];
//       NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
//        NSLog(@"===============%@",token);
//        [SVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
//        [APPDELEGATE presentToLoginViewController];
//        return result;
//    }
//    else if (statusCode == 999) {//999 代表数据升级或功能维护
////        [UserDefault removeObjectForKey:TOKEN];
////        NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
////        NSLog(@"===============%@",token);
////        [SVProgressHUD showErrorWithStatus:@"数据升级或功能维护"];
//        result[kCTApiProxyValidateResultKeyResponseObject] = @{@"message":@"数据升级或功能维护",@"statusCode":@"999"};
//        result[kCTApiProxyValidateResultKeyResponseString] = @"message:数据升级或功能维护,statusCode:999";
//        return result;
//    }
    
//    if (!responseObject) {
//        return result;
//    }

    if ([responseObject isKindOfClass:[NSData class]]) {
//        result[kCTApiProxyValidateResultKeyResponseString] = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        result[kCTApiProxyValidateResultKeyResponseString] = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
        result[kCTApiProxyValidateResultKeyResponseObject] = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
    } else {
        //这里的kCTApiProxyValidateResultKeyResponseString是用作打印日志用的，实际使用时可以把实际类型的对象转换成string用于日志打印
        //        result[kCTApiProxyValidateResultKeyResponseString] = responseObject;
        
        id object;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary * objectDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            [objectDic setObject:@(statusCode) forKey:@"statusCode"];
            object = objectDic;
        } else {
            object = @{@"statusCode":@(statusCode)};
        }
        
        result[kCTApiProxyValidateResultKeyResponseObject] = object;
    }
    
    return result;
}

- (BOOL)handleCommonErrorWithResponse:(CTURLResponse *)response manager:(CTAPIBaseManager *)manager errorType:(CTAPIManagerErrorType)errorType
{
    // 业务上这些错误码表示需要重新登录
    NSString *resCode = [NSString stringWithFormat:@"%@", response.content[@"status"]];
    if ([resCode isEqualToString:@"401"]
        || [resCode isEqualToString:@"05111001"]
        || [resCode isEqualToString:@"05111002"]
        || [resCode isEqualToString:@"1080002"]
        ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kCTUserTokenIllegalNotification
                                                            object:nil
                                                          userInfo:@{
                                                                     kCTUserTokenNotificationUserInfoKeyManagerToContinue:self
                                                                     }];
        
        return NO;
    }
    
    // 业务上这些错误码表示需要刷新token
    NSString *errorCode = [NSString stringWithFormat:@"%@", response.content[@"errorCode"]];
    if ([response.content[@"errorMsg"] isEqualToString:@"invalid token"]
        || [response.content[@"errorMsg"] isEqualToString:@"access_token is required"]
        || [errorCode isEqualToString:@"BL10015"]
        ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kCTUserTokenInvalidNotification
                                                            object:nil
                                                          userInfo:@{
                                                                     kCTUserTokenNotificationUserInfoKeyManagerToContinue:self
                                                                     }];
        return NO;
    }
    
    return YES;
}

#pragma mark - getters and setters
//- (NSString *)publicKey
//{
//    return @"";
//}
//
//- (NSString *)privateKey
//{
//    return @"";
//}


//- (void)checkMethodName:(NSString *)methodName
//{
//    self.isOldURL = [self.oldInterfaceArray containsObject:methodName];
//}

//- (NSArray *)oldInterfaceArray
//{
//    return @[];
//}

- (NSString *)baseURL {
//    NSString * serviceURL = [UserDefault stringValueForKey:@"ServiceURL"];
//    serviceURL = serviceURL ? serviceURL : Service_URL;
//    NSString * baseURL = [NSString stringWithFormat:@"%@%@",serviceURL,Api];
    
    NSString * baseURL = [NSString stringWithFormat:@"%@%@",Service_URL,Api];
    return baseURL;
}

- (CTServiceAPIEnvironment)apiEnvironment
{
    return CTServiceAPIEnvironmentReleaseCandidate;
}

- (AFHTTPRequestSerializer *)requestSerializer
{
    if (self.isOldURL) {
        _requestSerializer = self.httpRequestSerializer;
    } else {
        _requestSerializer = self.jsonRequestSerializer;
    }
    _requestSerializer.timeoutInterval = 20.f;

    return _requestSerializer;
}

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    }
    _httpRequestSerializer.timeoutInterval = 20.f;
    return _httpRequestSerializer;
}

- (AFJSONRequestSerializer *)jsonRequestSerializer
{
    if (_jsonRequestSerializer == nil) {
        _jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    //设置请求头相关
    
//    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:Token];

    //当token不存在的时候必须设置为nil,不然重新登录的时候header会取之前存的token,登录会报错，返回401状态码
//    [_jsonRequestSerializer setValue:(token ? token : nil) forHTTPHeaderField:Token];
//    [_jsonRequestSerializer setValue:@"32" forHTTPHeaderField:@"terminal_client"];
//    [_jsonRequestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"terminal_client"];
    return _jsonRequestSerializer;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        //加上此句返回的数据为Data
//        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //是否允许无效证书(也就是自建证书),默认为NO
        _manager.securityPolicy.allowInvalidCertificates = YES;
        //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
        //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
        //如置为NO，建议自己添加对应域名的校验逻辑。
        _manager.securityPolicy.validatesDomainName = NO;
        
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    }
    
    return self.manager;
}

@end
