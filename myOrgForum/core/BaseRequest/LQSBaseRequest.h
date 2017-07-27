//
//  LQSBaseRequest.h
//  myOrgForum
//
//  Created by wangbo on 2017/7/8.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LQSBaseJSONModel;

@interface LQSBaseRequest : NSObject
    
/**
 *  GET请求的参数字典
 */
@property (nonatomic, strong) NSMutableDictionary *getParams;
    
/**
 *  POST请求的参数字典
 */
@property (nonatomic, strong) NSMutableDictionary *postParams;

//@property (nonatomic, strong) NSMutableDictionary *fileBodyParams;
    
/**
 *  重试次数
 */
@property (nonatomic, assign) NSInteger retryCount;

/**
 *  当前重试计数
 */
@property (nonatomic, assign) NSInteger currentRetryIndex;
    
    
    
- (void)requestWithSuccess:(void (^)(LQSBaseJSONModel *model, NSInteger statusCode))success
                   failure:(void (^)(NSError *error, NSInteger statusCode))failure;

@end
