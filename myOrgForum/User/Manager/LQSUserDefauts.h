//
//  LQSUserDefauts.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/9/2.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kUserDefauts [NSUserDefaults standardUserDefaults]
@interface LQSUserDefauts : NSObject
//第一次加载app
+ (BOOL)isFirstLaunch;
//保存第一次加载
+ (void)saveFirstLaunch:(BOOL)isFirstLaunch;

//保存登陆信息
+ (void)saveLogin:(BOOL)isLogin;
+ (BOOL)isLogin;

//用户名
+ (void)saveUserName:(NSString *)userName;
+ (NSString *)getUserName;


@end
