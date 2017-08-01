//
//  LQSConstants.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//


/**
 *  返回结果的统一回调
 *
 *  @param result 返回结果
 *  @param error  错误返回
 */
typedef void (^resultBlock)(id result, NSError *error);

#define LQS_ERROR_DOMAIN @"LQSForum"
#define LQS_ForumKey @""
#define LQS_SDKVERSION @"2.4.0"

typedef NS_ENUM(NSInteger, LQSError){
    /** 未知错误 */
    ERR_CODE_UNKNOWN            = -400,
    /** 网络未连接 */
    ERR_CODE_REQUEST_NET_NOTREACHABLE   = -504,
    /** 发送超时 */
    ERR_CODE_REQUEST_TIMEOUT    = -505,
    /** 未登录 */
    ERR_CODE_AUTH_FAIL    = -506,
};