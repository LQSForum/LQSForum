//
//  LQSBaseManager.h
//  myOrgForum
//
//  Created by SongKuangshi on 16-8-5.
//  Copyright (c) 2016年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  整个系统管理者基类
 */
@interface LQSBaseManager : NSObject

@property (nonatomic, strong) NSString *appHash;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *token;

/**
 *	@brief	默认的管理者
 *
 *	@return	返回单例的默认管理者
 */
+ (instancetype)defaultManager;

/**
 *	@brief	销毁管理者,子类实现
 */
+ (void)destoryDefault;

/**
 *	@brief	更新appHash
 *
 *	@param 	apphash
 */
- (void)setUpWithApphash:(NSString *)appHash;

/**
 *	@brief	更新secret
 *
 *	@param 	secret
 */
- (void)resetCurrentSecret:(NSString *)secret;
/**
 *	@brief	更新Token
 *
 *	@param 	token
 */
- (void)reloadToken:(NSNumber *)token;


@property (nonatomic, strong) id observerController;
/**
 *	@brief	注册观察者
 *
 *	@param 	observer 	观察对象
 */
- (void)registManagerObserver:(id)observer;

/**
 *	@brief	移除观察者
 *
 *	@param 	observer 	观察对象
 */
- (void)removeManagerObserver:(id)observer;

/**
 *	@brief	注册观察者
 *
 *	@param 	observer 	观察对象
 */
+ (void)registManagerObserver:(id)observer;

/**
 *	@brief	移除观察者
 *
 *	@param 	observer 	观察对象
 */
+ (void)removeManagerObserver:(id)observer;


@end

