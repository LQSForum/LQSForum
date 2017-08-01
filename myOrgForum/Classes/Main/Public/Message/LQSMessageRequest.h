//
//  LQSMessageRequest.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseRestRequest.h"

typedef NS_ENUM(NSUInteger, LQSNotifyMessageType) {
    SYSTEM = 1,
    POST,
    AT,
    SESSION
};

@interface LQSMessageRequest : LQSBaseRestRequest

- (void)fetchUnReadCount:(NSInteger)timeout completionBlock:(resultBlock)block;
- (void)fetchNotifyMessagesWithType:(LQSNotifyMessageType)type pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completionBlock:(resultBlock)block;
- (void)fetchSessionMessagesWithPage:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completionBlock:(resultBlock)block;

@end
