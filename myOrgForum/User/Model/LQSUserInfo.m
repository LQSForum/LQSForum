//
//  LQSUserInfo.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSUserInfo.h"

@implementation LQSUserInfo

- (NSMutableArray *)creditList {
    if (!_creditList) {
        _creditList = [NSMutableArray array];
    }
    return _creditList;
}

@end

@implementation LQSUserCreditShow
@end