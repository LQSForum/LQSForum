//
//  LQSCore.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/7/19.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSCore : NSObject
//是否已经登陆
@property (nonatomic, readonly, assign) BOOL isLogined;

- (void)authWithLoginName:(NSString *)loginName
                 password:(NSString *)password
                    param:(NSDictionary *)param;

- (void)logoutRequest;


@end
