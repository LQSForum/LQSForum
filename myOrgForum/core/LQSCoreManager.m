//
//  LQSCoreManager.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/11.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSCoreManager.h"

@implementation LQSCoreManager


#pragma mark - Http common 







- (void)HttpsPost:(NSString *)URLStr
           params:(id)params
          success:(void (^)(id))success
          failure:(void (^)(NSError *error))failure{

    if (!kNetworkIsReached) {
        kNetworkNotReachedMessage;
        if (failure) {
            NSError *_error = [[NSError alloc] initWithDomain:@"网络好像有点问题" code:1012 userInfo:nil];
            failure(_error);
        }
        return;
    }
    self.htttpRequestSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.htttpRequestSessionManager POST:URLStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}



- (AFHTTPSessionManager *)htttpRequestSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[self securityPolicy]];

    return manager;
}

- (AFSecurityPolicy *)securityPolicy
{

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    return securityPolicy;


}

@end
