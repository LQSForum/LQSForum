//
//  LQSMessageCenterManager.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseManager.h"

@protocol LQSMessageObserver <NSObject>

@optional

- (void)onReceiveNewMessage:(NSDictionary *)dict;

@end

@interface LQSMessageCenterManager : LQSBaseManager

@end
