//
//  LQSMessage.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSMessage.h"

@implementation LQSMessage

+ (instancetype)modelMsg:(id)dict {
    if (dict[@"pmid"]) {
        return [LQSSessionMessage modelMsg:dict];
    } else {
        return [LQSNotifyMessage modelMsg:dict];
    }
}

@end

@implementation LQSSessionMessage

@end

@implementation LQSNotifyMessage

@end