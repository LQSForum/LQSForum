//
//  LQSUserRequest.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSUserRequest.h"

@implementation LQSUserRequest

- (void)registerUserByEmail:(NSString *)email withPWD:(NSString *)password withUserName:(NSString *)username completionBlock:(resultBlock)block {
    NSMutableDictionary *params = [self parameters];
    
    [params setObject:password forKey:@"password"];
    [params setObject:email forKey:@"email"];
    [params setObject:username forKey:@"username"];
    [params setObject:@"1" forKey:@"isValidation"];
    
    NSString *url = [self getURLStringForPath:@"user/register"];
    [super POST:url parameters:params block:block];
}

- (void)updateUserByGender:(LQSTypeGender)gender withAvatarUrl:(NSString *)avatarUrl withUserName:(NSString *)username completionBlock:(resultBlock)block {
    NSMutableDictionary *params = [self parameters];
    
    [params setObject:[NSString stringWithFormat:@"%lu", (unsigned long)gender] forKey:@"gender"];
    [params setObject:username forKey:@"username"];
    [params setObject:@"info" forKey:@"type"];
    [params setObject:avatarUrl forKey:@"avatarUrl"];
    
    NSString *url = [self getURLStringForPath:@"user/updateuserinfo"];
    [super POST:url parameters:params block:block];
}

- (void)loginUserByUsername:(NSString *)username withPWD:(NSString *)password completionBlock:(resultBlock)block {
    NSMutableDictionary *params = [self parameters];
    
    params[@"password"] = password;
    params[@"type"] = @"login";
    params[@"username"] = username;
    params[@"isValidation"] = @"1";

    
//    [params setObject:password forKey:@"password"];
//    [params setObject:@"login" forKey:@"type"];
//    [params setObject:username forKey:@"username"];
//    [params setObject:@"1" forKey:@"isValidation"];
    
    NSString *url = [self getURLStringForPath:@"user/login"];
    [super POST:url parameters:params block:block];
}

- (void)logoutUserByUsername:(NSString *)username withPWD:(NSString *)password completionBlock:(resultBlock)block {
    NSMutableDictionary *params = [self parameters];
    
    [params setObject:@"logout" forKey:@"type"];
    [params setObject:username forKey:@"username"];
    [params setObject:password forKey:@"password"];
    
    NSString *url = [self getURLStringForPath:@"user/login"];
    [super POST:url parameters:params block:block];
}

@end
