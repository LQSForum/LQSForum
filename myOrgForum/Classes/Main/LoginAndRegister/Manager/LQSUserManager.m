//
//  LQSUserManager.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSUserManager.h"
#import "LQSUserRequest.h"
#import "LQSBaseModel_Private.h"

NSString * const KLQSLoginSuccessNotification = @"KLQSLoginSuccessNotification";
NSString * const KLQSLoginFailedNotification = @"KLQSLoginFailedNotification";

@implementation LQSUserManager

+ (instancetype)userManager{

    static id userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        userManager = [[LQSUserManager alloc]init];
    });

    return userManager;

}

+ (BOOL)isLoging{
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    return [defauts objectForKey:kUserInfo] != nil;
}

+ (LQSUserInfo *)user{
    if (![LQSUserManager userManager].currentOnlineUser && [LQSUserManager isLoging] ) {
        return [self userWithDict:[LQSUserManager userDict]];
    }
    return [LQSUserManager userManager].currentOnlineUser;



}

+(NSDictionary *)userDict{
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    return [defauts objectForKey:kUserInfo];

}

+ (LQSUserInfo *)userWithDict:(NSDictionary *)dict{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    [defauts setValue:dict forKey:kUserInfo];
    [defauts synchronize];
    
    NSError *error = nil;
    LQSUserInfo *user = [[LQSUserInfo class] mj_objectWithKeyValues:dict];

    if (error) {
        return nil;
    }
    
    [LQSUserManager userManager].currentOnlineUser = user;
    return user;

}

+ (void)clearUser{
    [LQSUserManager userManager].currentOnlineUser = nil;
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    [defauts removeObjectForKey:kUserInfo];
    [defauts synchronize];



}





-(void) clearAccessInfo {
    super.secret = nil;
    super.token = nil;
    self.currentOnlineUser = nil;
}

- (void)registerUserByEmail:(NSString *)email withPWD:(NSString *)password withUserName:(NSString *)username completionBlock:(resultBlock)block {
    LQSUserRequest *request = [LQSUserRequest defaultModel];
    [request registerUserByEmail:email withPWD:password withUserName:username completionBlock:^(id result, NSError *error) {
        LQSUserInfo *userinfo = nil;
        if (!error) {
            userinfo = [LQSUserInfo model:result];
            if (!userinfo) {
                assert(@"parse err");
            }
            userinfo.dicData = [result copy];
            NSArray *list = result[@"creditShowList"];
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [userinfo.creditList addObject:[LQSUserCreditShow model:obj]];
            }];
            self.currentOnlineUser = [userinfo copy];
            [[LQSUserManager defaultManager] resetCurrentSecret:result[@"secret"]];
            [[LQSUserManager defaultManager] reloadToken:result[@"token"]];
        }
        block(userinfo, error);
    }];
}


- (void)updateUserByGender:(LQSTypeGender)gender withAvatarUrl:(NSString *)avatarUrl withUserName:(NSString *)username completionBlock:(resultBlock)block {
    LQSUserRequest *request = [LQSUserRequest defaultModel];
    [request updateUserByGender:gender withAvatarUrl:avatarUrl withUserName:username completionBlock:^(id result, NSError *error) {
        if (!error) {
            self.currentOnlineUser.gender = gender;
            self.currentOnlineUser.avatar = avatarUrl;
            self.currentOnlineUser.userName = username;
        }
        block(result, error);
    }];
}

- (void)loginUserByUsername:(NSString *)username withPWD:(NSString *)password completionBlock:(resultBlock)block {
    if (self.currentOnlineUser) {
        if ([self.currentOnlineUser.userName isEqualToString:username]) {
            block(nil, [NSError errorWithDomain:LQS_ERROR_DOMAIN code:ERR_CODE_AUTH_FAIL userInfo:[NSDictionary dictionaryWithObject:@"当前用户已登录" forKey:@"err_msg"]]);
        } else {
            block(nil, [NSError errorWithDomain:LQS_ERROR_DOMAIN code:ERR_CODE_AUTH_FAIL userInfo:[NSDictionary dictionaryWithObject:@"上一个用户未登出" forKey:@"err_msg"]]);
        }
        return;
    }
    LQSUserRequest *request = [LQSUserRequest defaultModel];
    [request loginUserByUsername:username withPWD:password completionBlock:^(id result, NSError *error) {
        LQSUserInfo *userinfo = nil;
        if (!error) {
            userinfo = [LQSUserInfo model:result];
            if (!userinfo) {
                assert(@"parse err");
            }
            userinfo.dicData = [result copy];
            NSArray *list = result[@"creditShowList"];
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [userinfo.creditList addObject:[LQSUserCreditShow model:obj]];
            }];
            self.currentOnlineUser = [userinfo copy];
            [[LQSUserManager defaultManager] resetCurrentSecret:result[@"secret"]];
            [[LQSUserManager defaultManager] reloadToken:result[@"token"]];
            
            [self.observerController didAuthSuccess:userinfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:KLQSLoginSuccessNotification object:userinfo];
        } else {
            [self.observerController didAuthFailed:error];
            [[NSNotificationCenter defaultCenter] postNotificationName:KLQSLoginFailedNotification object:error];
        }
        block(userinfo, error);
    }];
}

- (void)logoutUserByUsername:(NSString *)username withPWD:(NSString *)password completionBlock:(resultBlock)block {
    if (self.currentOnlineUser == nil || ![self.currentOnlineUser.userName isEqualToString:username]) {
        block(nil, [NSError errorWithDomain:LQS_ERROR_DOMAIN code:ERR_CODE_AUTH_FAIL userInfo:[NSDictionary dictionaryWithObject:@"不是当前登录用户" forKey:@"err_msg"]]);
        return;
    }
    LQSUserRequest *request = [LQSUserRequest defaultModel];
    [request logoutUserByUsername:username withPWD:password completionBlock:^(id result, NSError *error) {
        if (!error) {
            [self.observerController didLogoutSuccess:self.currentOnlineUser];
            [self clearAccessInfo];
        } else {
            [self.observerController didLogoutFailed:error];
        }
        block(result, error);
    }];
}

@end
