//
//  HYUKBaseRequset.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/18.
//

#import "HYUKBaseRequset.h"

static AFHTTPSessionManager *manager = nil;

@implementation HYUKBaseRequset

+ (AFHTTPSessionManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFHTTPRequestSerializer *requestSerializer = [[AFHTTPRequestSerializer alloc] init];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                
        AFHTTPResponseSerializer *responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
        
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        securityPolicy.allowInvalidCertificates = YES;
//        securityPolicy.validatesDomainName = NO;
//        HYVideoMoiveListModel *s = [HYVideoMoiveListModel new];
        
        manager = [AFHTTPSessionManager manager];
        
        // 设置接受解析的内容类型
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.securityPolicy = securityPolicy;
//        [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
//        [manager.requestSerializer setValue:@"https://zx.cafoh.cn/shouxiangyanjiuyuan/shoot?channel=swharry1091" forHTTPHeaderField:@"referer"];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];

//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });
    return manager;
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params complationHandle:(void (^)(id, NSError *))completed {
    return [[self defaultManager] GET:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"path相应参数:%@\n请求参数:%@\nresponse:%@",path,params,responseObject);
//        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        completed(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        completed(nil,error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params complationHandle:(void (^)(id, NSError *))completed {
    
    return [[self defaultManager] POST:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"path相应参数:%@\n请求参数:%@\nresponse:%@",path,params,responseObject);
//        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        completed(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

@end
