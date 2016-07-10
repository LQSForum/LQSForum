//
//  LQSUserBasicInfo.m
//  myOrgForum
//
//  Created by XJW on 16/7/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSUserBasicInfo.h"


static LQSUserBasicInfo * _sharedLQSUserBasicInfo = nil;
@implementation LQSUserBasicInfo


+(LQSUserBasicInfo *)sharedSouFunUserBasicInfo
{
    @synchronized([LQSUserBasicInfo class])
    {
        if (!_sharedLQSUserBasicInfo)
            _sharedLQSUserBasicInfo = [[LQSUserBasicInfo alloc] init];
        
        return _sharedLQSUserBasicInfo;
    }
    
    return nil;
}


@end
