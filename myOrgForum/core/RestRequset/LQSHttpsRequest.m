//
//  LQSHttpsRequest.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSHttpsRequest.h"
#import "AFURLRequestSerialization.h"

@interface LQSHttpsRequest ()

@property (nonatomic, strong)AFHTTPSessionManager *manager;

@end

@implementation LQSHttpsRequest

- (id) init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
  
              //设置返回值格式
     //   self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [self setSecruityPolity];
    }
    return self;
}


- (void)setSecruityPolity{
    /**** SSL Pinning ****/
    //设置安全，允许不合法证书
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    
    [self.manager setSecurityPolicy:securityPolicy];
    
    [self.manager.requestSerializer setTimeoutInterval:15];
}

- (void)setIsJsonPara:(BOOL)isJsonPara{
    _manager.requestSerializer = isJsonPara ? [AFJSONRequestSerializer serializer] : [AFHTTPRequestSerializer serializer];
}

- (void )GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure {
    
    if ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable){
        if (failure){
            failure([NSError errorWithDomain:LQS_ERROR_DOMAIN code:ERR_CODE_REQUEST_NET_NOTREACHABLE userInfo:[NSDictionary dictionaryWithObject:@"网络未连接" forKey:@"err_msg"]]);
        }
        return;
    }
    
    /**** URL转换 ****/
    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.manager.session invalidateAndCancel];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"httpsRequest Failed:%@,%@",task.currentRequest, error);
        [self.manager.session invalidateAndCancel];
        failure(error);
    }];
}

- (void )POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure{
    
    if ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable){
        if (failure){
            failure([NSError errorWithDomain:LQS_ERROR_DOMAIN code:ERR_CODE_REQUEST_NET_NOTREACHABLE userInfo:[NSDictionary dictionaryWithObject:@"网络未连接" forKey:@"err_msg"]]);
        }
        return;
    }
    
    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.manager.session invalidateAndCancel];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.manager.session invalidateAndCancel];
        failure(error);
    }];
}

@end
