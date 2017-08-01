//
//  LQSUserInfo.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSUserInfo.h"

@implementation LQSUserInfo

- (id)copyWithZone:(NSZone *)zone
{
    LQSUserInfo *copy = [[[self class] allocWithZone:zone] init];
    copy.dicData = _dicData;
    copy.userName = _userName;
    copy.uid = _uid;
    copy.gender = _gender;
    copy.score = _score;
    copy.avatar = _avatar;
    copy.userTitle = _userTitle;
    copy.creditList = _creditList;

    return copy;
}



- (NSMutableArray *)creditList {
    if (!_creditList) {
        _creditList = [NSMutableArray array];
    }
    return _creditList;
}

@end

@implementation LQSUserCreditShow
@end