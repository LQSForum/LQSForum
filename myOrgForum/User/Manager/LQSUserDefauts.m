//
//  LQSUserDefauts.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/9/2.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSUserDefauts.h"

@implementation LQSUserDefauts

+ (BOOL)isFirstLaunch
{
    return [kUserDefauts boolForKey:@"isFirstLaunch"];


}

+ (void)saveFirstLaunch:(BOOL)isFirstLaunch
{

    [kUserDefauts removeObjectForKey:@"isFirstLaunch"];
    [kUserDefauts setBool:isFirstLaunch forKey:@"isFirstLaunch"];
    [kUserDefauts synchronize];

}

+ (void)saveLogin:(BOOL)isLogin{

    [kUserDefauts removeObjectForKey:@"isLogin"];
    [kUserDefauts setBool:isLogin forKey:@"isLogin"];
    [kUserDefauts synchronize];
}

+ (BOOL)isLogin
{
    return [kUserDefauts boolForKey:@"isLogin"];


}

+ (void)saveUserName:(NSString *)userName
{

    [kUserDefauts removeObjectForKey:@"userName"];
    [kUserDefauts setObject:userName forKey:@"userName"];
    [kUserDefauts synchronize];

}

+ (NSString *)getUserName
{
    return [kUserDefauts stringForKey:@"userName"];



}
@end
