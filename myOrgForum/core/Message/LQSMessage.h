//
//  LQSMessage.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseModel.h"

@interface LQSMessage : LQSBaseModel
+ (instancetype)modelMsg:(id)dict;
@end

@interface LQSSessionMessage : LQSMessage

@property (nonatomic, strong) NSNumber *plid;
@property (nonatomic, strong) NSNumber *pmid;
@property (nonatomic, strong) NSNumber *lastUserId;
@property (nonatomic, strong) NSString *lastUserName;
@property (nonatomic, strong) NSString *lastSummary;
@property (nonatomic, strong) NSString *lastDateline;
@property (nonatomic, strong) NSNumber *toUserId;
@property (nonatomic, strong) NSString *toUserAvatar;
@property (nonatomic, strong) NSString *toUserName;
@property (nonatomic, strong) NSNumber *toUserIsBlack;
@property (nonatomic, strong) NSNumber *isNew;

@end

@interface LQSNotifyMessage : LQSMessage

@property (nonatomic, strong) NSString *replied_date;
@property (nonatomic, strong) NSString *mod;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) NSString *is_read;
@property (nonatomic, strong) NSString *type;

@end