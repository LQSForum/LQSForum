//
//  LQSAppDelegate.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSAppDelegate.h"
#import "UIWindow+Extension.h"

#import "AFNetworking.h"
#import "LQSCoreManager.h"

@interface LQSAppDelegate()


@end

@implementation LQSAppDelegate
+ (LQSAppDelegate *)shareAppDelegate
{
    return (LQSAppDelegate *)[UIApplication sharedApplication].delegate;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   [self.window chooseRootViewController];

    [self.window makeKeyAndVisible];
    [self getUserInfor];
    return YES;
}
/*
 r:user/login
 password:12345678lqs
 sdkVersion:2.4.0
 isValidation:1
 apphash:95f64b0e
 username:乐梅宝
 accessToken:
 type : login
 accessSecret:
 forumKey : BW0L5ISVRsOTVLCTJx
 */

- (void)getUserInfor
{
    NSString *loginUrlStr = @"http://forum.longquanzs.org/mobcent/app/web/index.php?";
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"r"] = @"user/login";
    params[@"sdkVersion"] = @"2.4.0";
    params[@"isValidation"] = @"1";
    params[@"apphash"] = @"95f64b0e";
    params[@"username"] = @"乐梅宝";
    params[@"password"] = @"12345678lqs";
    params[@"accessToken"] = @"";
    params[@"type"] = @"login";
    params[@"accessSecret"] = @"";
    params[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    
    [session POST:loginUrlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSDictionary *resultDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSLog(@"请求数据：%@",resultDic);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求成功");
    }];
    
    
}



@end
