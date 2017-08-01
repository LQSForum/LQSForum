//
//  LQSMessageCenterManager.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSMessageCenterManager.h"
#import "LQSUserManager.h"
#import "LQSMessageRequest.h"
#import "LQSMessage.h"

#define MsgStorePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@interface LQSMessageCenterManager ()
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSMutableDictionary *unReadCount;
@property (strong, nonatomic) NSMutableArray *notifyMessages;
@property (strong, nonatomic) NSMutableArray *sessionMessages;
@end

@implementation LQSMessageCenterManager

-(instancetype)init {
    self = [super init];
    if (self) {
        self.notifyMessages = [NSKeyedUnarchiver unarchiveObjectWithFile:[MsgStorePath stringByAppendingPathComponent:@"notifyMsgData"]];
        self.notifyMessages = [NSKeyedUnarchiver unarchiveObjectWithFile:[MsgStorePath stringByAppendingPathComponent:@"sessionMsgData"]];
        self.unReadCount = [[NSMutableDictionary alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:KLQSLoginSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailed:) name:KLQSLoginFailedNotification object:nil];
    }
    return self;
}

- (void)initTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 * 60.0f target:self selector:@selector(fetchMessageList) userInfo:nil repeats:YES];
    }
}

-(void)fetchMessageList {
    LQSMessageRequest *request = [LQSMessageRequest defaultModel];
    [request fetchUnReadCount:5000 completionBlock:^(id result, NSError *error) {
        if (!error) {
            NSDictionary *body = result[@"body"];
            if (body) {
                int ans = 0;
                if (body[@"replyInfo"] && body[@"replyInfo"][@"count"]) {
                    NSObject *obj = body[@"replyInfo"][@"count"];
                    if ([self validateNumber:obj] > 0) {
                        ans |= 1;
                        [self.unReadCount setObject:@([self validateNumber:obj]) forKey:@(POST)];
                    }
                }
                if (body[@"atMeInfo"] && body[@"atMeInfo"][@"count"]) {
                    NSObject *obj = body[@"atMeInfo"][@"count"];
                    if ([self validateNumber:obj] > 0) {
                        ans |= 1 << 1;
                        [self.unReadCount setObject:@([self validateNumber:obj]) forKey:@(AT)];
                    }
                }
                if (body[@"systemInfo"] && body[@"systemInfo"][@"count"]) {
                    NSObject *obj = body[@"systemInfo"][@"count"];
                    if ([self validateNumber:obj] > 0) {
                        ans |= 1 << 2;
                        [self.unReadCount setObject:@([self validateNumber:obj]) forKey:@(SYSTEM)];
                    }
                }
                if (body[@"pmInfos"]) {
                    NSArray *array = body[@"pmInfos"];
                    if (array && array.count > 0) {
                        ans |= 1 << 3;
                        [self.unReadCount setObject:@(array.count) forKey:@(SESSION)];
                    }
                }
                [self triggerFetchMessage:ans];
            }
        }
    }];
}

-(void)triggerFetchMessage:(int)ans {
    if (ans == 0) {
        return;
    }
    self.notifyMessages = [[NSMutableArray alloc] init];
    self.sessionMessages = [[NSMutableArray alloc] init];
    if (ans & 1) {
        LQSMessageRequest *request = [LQSMessageRequest defaultModel];
        [request fetchNotifyMessagesWithType:POST pageIndex:0 pageSize:20 completionBlock:^(id result, NSError *error) {
            NSArray *msgs = result[@"body"][@"data"];
            [msgs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self appendMsg:[LQSMessage modelMsg:obj]];
            }];
        }];
    }
    if (ans & (1 << 1)) {
        LQSMessageRequest *request = [LQSMessageRequest defaultModel];
        [request fetchNotifyMessagesWithType:AT pageIndex:0 pageSize:20 completionBlock:^(id result, NSError *error) {
            NSArray *msgs = result[@"body"][@"data"];
            [msgs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self appendMsg:[LQSMessage modelMsg:obj]];
            }];
        }];
    }
    if (ans & (1 << 2)) {
        LQSMessageRequest *request = [LQSMessageRequest defaultModel];
        [request fetchNotifyMessagesWithType:SYSTEM pageIndex:0 pageSize:20 completionBlock:^(id result, NSError *error) {
            NSArray *msgs = result[@"body"][@"data"];
            [msgs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self appendMsg:[LQSMessage modelMsg:obj]];
            }];
        }];
    }
    if (ans & (1 << 3)) {
        LQSMessageRequest *request = [LQSMessageRequest defaultModel];
        [request fetchSessionMessagesWithPage:0 pageSize:20 completionBlock:^(id result, NSError *error) {
            NSArray *msgs = result[@"body"][@"list"];
            [msgs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.sessionMessages addObject:[LQSMessage modelMsg:obj]];
            }];
        }];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.notifyMessages];
    [data writeToFile:[MsgStorePath stringByAppendingPathComponent:@"notifyMsgData"] atomically:YES];
    data = [NSKeyedArchiver archivedDataWithRootObject:self.sessionMessages];
    [data writeToFile:[MsgStorePath stringByAppendingPathComponent:@"sessionMsgData"] atomically:YES];
    [self.observerController onReceiveNewMessage:@{@"unread": self.unReadCount.copy, @"notify" : self.notifyMessages.copy, @"session" : self.sessionMessages.copy}];
}

- (void)appendMsg:(LQSMessage *)msg {
    @synchronized (self.notifyMessages) {
        [self.notifyMessages addObject:msg];
    }
}

-(int)validateNumber:(NSObject *)obj {
    if ([obj isMemberOfClass:[NSNumber class]]) {
        NSNumber *num = (NSNumber *)obj;
        return [num intValue];
    } else if ([obj isMemberOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        return [str intValue];
    }
    return 0;
}

-(void)loginSuccess:(NSNotification *)notification {
    [self initTimer];
}
-(void)loginFailed:(NSNotification *)notification {
    [_timer invalidate];
    _timer = nil;
}

@end
