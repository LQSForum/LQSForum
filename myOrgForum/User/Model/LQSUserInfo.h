//
//  LQSUserInfo.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseModel.h"

typedef NS_ENUM(NSUInteger, LQSTypeGender) {
    MAN = 1,
    WOMAN,
};

@interface LQSUserInfo : LQSBaseModel<NSCopying>

@property (strong, nonatomic) NSDictionary *dicData;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSNumber *uid;
@property (assign, nonatomic) LQSTypeGender gender;
@property (strong, nonatomic) NSString *score;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *userTitle;
@property (strong, nonatomic) NSMutableArray *creditList;

@end

@interface LQSUserCreditShow : LQSBaseModel

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *data;

@end