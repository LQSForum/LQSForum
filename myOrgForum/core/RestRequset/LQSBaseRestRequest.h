//
//  LQSBaseRestRequest.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseModel.h"

@interface LQSBaseRestRequest : LQSBaseModel

/** 请求带的不定参数，外层传递进来的参数，非默认的或固定的参数 */
@property (strong, nonatomic) NSMutableDictionary *parameters;

//用于处理不同的bduss情况下的请求
@property (strong, nonatomic) NSString *token;

//域名
@property (strong, nonatomic) NSString *domain;

@property (assign, nonatomic) BOOL isJsonRequestPara;

/**
 *  @brief  获取urlString
 *
 *  @param path 相对路径
 *
 *  @return url
 */
- (NSString *)getURLStringForPath:(NSString *)path;

/**
 *  GET 请求
 *
 *  @param URLString  请求URL
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void )GET:(NSString *)URLString
  parameters:(NSDictionary *)parameters
       block:(resultBlock)block;

/**
 *  POST 请求
 *
 *  @param URLString  POST请求URL
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void )POST:(NSString *)URLString
   parameters:(NSDictionary *)parameters
        block:(resultBlock)block;

@end
