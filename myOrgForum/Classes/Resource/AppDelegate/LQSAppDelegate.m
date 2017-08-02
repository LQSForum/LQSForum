//
//  LQSAppDelegate.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSAppDelegate.h"
#import "UIWindow+Extension.h"
#import "UIColor+Hex.h"

#import "AFNetworking.h"
#import "LQSMessageCenterManager.h"

#import <UMSocialCore/UMSocialCore.h>

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
    [UINavigationBar appearance].barTintColor = [UIColor lqs_themeColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0f],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [self.window makeKeyAndVisible];
    
    [self getUserInfor];
    [LQSMessageCenterManager defaultManager];
    
    // U-Share
    /* 打开调试日志 */
//    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58ac21df04e205455d000b74"];
    
    [self configUSharePlatforms];
    
    return YES;
}

#pragma U-Share
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx5fcc8bb4f9f2ddc5" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2030350080"  appSecret:@"6e01add695f5000ed373e436bbda860d" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
   
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
        //NSLog(@"请求数据：%@",resultDic);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求成功");
    }];
    
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        
    }
    return result;
}



@end
