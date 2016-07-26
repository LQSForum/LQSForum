//
//  LQSUserBasicInfo.h
//  myOrgForum
//
//  Created by XJW on 16/7/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LQSUserBasicInfo : NSObject


@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *userTitle;//新手上路
@property (nonatomic, strong) NSString *repeatList;
@property (nonatomic, strong) NSString *verify;
@property (nonatomic, strong) NSString *credits;  //积分；
@property (nonatomic, strong) NSString *extcredits2; //香华
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *externInfo;
@property (nonatomic, strong) NSString *padding;
@property (nonatomic, strong) NSString *isValidation;


+(LQSUserBasicInfo *)sharedSouFunUserBasicInfo;

@end
