//
//  LQSMessageRequest.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSMessageRequest.h"

@implementation LQSMessageRequest

- (void)fetchUnReadCount:(NSInteger)timeout completionBlock:(resultBlock)block {
    NSMutableDictionary *params = [self parameters];
    [params setObject:@(timeout) forKey:@"socket_timeout"];
    [params setObject:@(timeout) forKey:@"connection_timeout"];
    NSString *url = [self getURLStringForPath:@"message/heart"];
    [super POST:url parameters:params block:block];
}

- (void)fetchNotifyMessagesWithType:(LQSNotifyMessageType)type pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completionBlock:(resultBlock)block {
    NSMutableDictionary *params = [self parameters];
    [params setObject:@(pageIndex) forKey:@"page"];
    [params setObject:@(pageSize) forKey:@"pageSize"];
    switch (type) {
        case SYSTEM:
            [params setObject:@"system" forKey:@"type"];
            break;
        case POST:
            [params setObject:@"post" forKey:@"type"];
            break;
        case AT:
            [params setObject:@"at" forKey:@"type"];
            break;
        default:
            break;
    }
    NSString *url = [self getURLStringForPath:@"message/notifylistex"];
    [super POST:url parameters:params block:block];
}

- (void)fetchSessionMessagesWithPage:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completionBlock:(resultBlock)block {
    NSMutableDictionary *params = [self parameters];
    [params setObject:@(pageIndex) forKey:@"page"];
    [params setObject:@(pageSize) forKey:@"pageSize"];
    NSString *url = [self getURLStringForPath:@"message/notifylistex"];
    [super POST:url parameters:params block:block];
}

@end
