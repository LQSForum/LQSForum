//
//  LQSUserManager.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseManager.h"
#import "LQSUserInfo.h"

extern NSString * const KLQSLoginSuccessNotification;
extern NSString * const KLQSLoginFailedNotification;

@protocol LQSUserAuthDelegate <NSObject>

@optional
/**
 *  @brief  登录成功
 *
 *  @param  返回的userinfo
 */
- (void)didAuthSuccess:(LQSUserInfo *)userinfo;
/**
 *  @brief  登录
 *
 *  @param error 返回的错误
 */
- (void)didAuthFailed:(NSError *)error;

/**
 *  @brief  退出登录成功
 *
 *  @param  返回退出登录成功的userinfo
 */
- (void)didLogoutSuccess:(LQSUserInfo *)userinfo;
/**
 *  @brief  退出登录失败
 *
 *  @param error 退出登录失败
 */
- (void)didLogoutFailed:(NSError *)error;

@end


@interface LQSUserManager : LQSBaseManager

@property (nonatomic, copy) LQSUserInfo *currentOnlineUser;


//zss
+ (BOOL)isLoging;

+ (instancetype)userManager;

+ (LQSUserInfo *)user;

+ (NSDictionary *)userDict;

+ (LQSUserInfo *)userWithDict:(NSDictionary *)dict;


+ (void)clearUser;


-(void) clearAccessInfo;

/**
 *  @brief  注册
 *
 *  @param email            邮箱
 *  @param password         密码
 *  @param username         用户名
 *  @param completionBlock  回调
 */
- (void)registerUserByEmail:(NSString *)email withPWD:(NSString *)password withUserName:(NSString *)username completionBlock:(resultBlock)block;

/**
 *  @brief  更新用户信息
 *
 *  @param gender           性别
 *  @param avatarUrl        头像Url
 *  @param username         用户名
 *  @param completionBlock  回调
 */
- (void)updateUserByGender:(LQSTypeGender)gender withAvatarUrl:(NSString *)avatarUrl withUserName:(NSString *)username completionBlock:(resultBlock)block;

/**
 *  @brief  登录
 *
 *  @param username         用户名
 *  @param password         密码
 *  @param completionBlock  回调
 */
- (void)loginUserByUsername:(NSString *)username withPWD:(NSString *)password completionBlock:(resultBlock)block;

/**
 *  @brief  登出
 *
 *  @param username         用户名
 *  @param password         密码
 *  @param completionBlock  回调
 */
- (void)logoutUserByUsername:(NSString *)username withPWD:(NSString *)password completionBlock:(resultBlock)block;
@end
