//
//  LQSBaseRestRequest.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseRestRequest.h"
#import "LQSHttpsRequest.h"
#import "LQSUserManager.h"

static NSString *Domain_Online =  @"forum.longquanzs.org/mobcent/app/web/index.php?r=";

@interface LQSBaseRestRequest ()

@property (strong, nonatomic) LQSHttpsRequest  *httpsRequest;

@end


@implementation LQSBaseRestRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _domain = [self getHost];
        _httpsRequest = [[LQSHttpsRequest alloc] init];
        
    }
    return self;
}

-(NSMutableDictionary *)parameters
{
    if (!_parameters) {
        _parameters = [NSMutableDictionary dictionary];
    }
    _parameters[@"forumKey"] = LQS_ForumKey;
    _parameters[@"accessSecret"] = [[LQSUserManager defaultManager] secret];
    _parameters[@"accessToken"] = [[LQSUserManager defaultManager] token];
    _parameters[@"sdkVersion"] = LQS_SDKVERSION;

    
    
    
    
    
//    [_parameters setObject:LQS_ForumKey forKey:@"forumKey"];
//    [_parameters setObject:[[LQSUserManager defaultManager] secret] forKey:@"accessSecret"];
//    [_parameters setObject:[[LQSUserManager defaultManager] token] forKey:@"accessToken"];
//    [_parameters setObject:LQS_SDKVERSION forKey:@"sdkVersion"];
    return _parameters;
}

- (NSString *)getURLStringForPath:(NSString *)path{
    NSString *host = [self getHost];
    NSString *scheme = @"http://";
    
    NSString *urlString = [self getURLStringForScheme:scheme host:host path:path];
    return urlString;
}

-(NSString *)getURLStringForScheme:(NSString*)scheme host:(NSString *)host path:(NSString *)path {
    NSString *urlString =[NSString stringWithFormat:@"%@%@/%@",scheme,host,path];
    return urlString;
}

- (NSString *)getHost {
    return Domain_Online;
}

- (void)setRequestCookie {
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"Token" forKey:NSHTTPCookieName];
    
    NSString *token = [self token];
    if (token.length) {
        [cookieProperties setObject:token forKey:NSHTTPCookieValue];
    }
    
    if (self.domain.length) {
        [cookieProperties setObject:self.domain forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:self.domain forKey:NSHTTPCookieOriginURL];
    }
    
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

- (void)setIsJsonRequestPara:(BOOL)jsonRequestPara {
    [self.httpsRequest setIsJsonPara:jsonRequestPara];
}

- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters block:(resultBlock)block{
    [self setRequestCookie];
    
    [self.httpsRequest GET:URLString parameters:parameters success:^(id responseObject) {
        [self responseObject:responseObject block:block];
    } failure:^(NSError *error) {
        NSLog(@"Rest-Fail: self:%@\nurl:%@\npara:%@\nerror:%@",self,URLString,parameters,error);
        block(nil, error);
    }];
}

- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters block:(resultBlock)block{
    [self setRequestCookie];
    [self.httpsRequest POST:URLString parameters:parameters success:^(id responseObject) {
        [self responseObject:responseObject block:block];
    } failure:^(NSError *error) {
        NSLog(@"Rest-Fail:self:%@\nurl:%@\npara:%@\nerror:%@",self,URLString,parameters,error);
        block(nil, error);
    }];
}

- (NSError *)errorFromResponseObject:(NSDictionary *)responseObject{
    NSError *retError = nil;
    NSNumber *errCodeNumber = responseObject[@"rs"];
    
    if (errCodeNumber) {
        int errorCode = errCodeNumber.intValue;
       
        retError = errorCode != 1 ? [NSError errorWithDomain:LQS_ERROR_DOMAIN code:errorCode userInfo:[NSDictionary dictionaryWithObject:responseObject[@"errcode"] forKey:@"err_msg"]] : nil;
    }
    
    return retError;
}

- (void)responseObject:(id)responseObject block:(resultBlock)block {
    
    NSError *retError = [NSError errorWithDomain:LQS_ERROR_DOMAIN code:ERR_CODE_UNKNOWN userInfo:[NSDictionary dictionaryWithObject:@"网络返回值错误" forKey:@"err_msg"]];
    id retObject = nil;
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        retError =  [self errorFromResponseObject:responseObject];
        retObject = retError ? nil : responseObject;
    }
    block(retObject, retError);
}

@end
