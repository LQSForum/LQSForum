//
//  LQSCommonDefine.h
//  myOrgForum
//
//  Created by XJW on 16/7/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#ifndef LQSCommonDefine_h
#define LQSCommonDefine_h
//用户信息
#define LQSToken @"token"
#define LQSSecret @"secret"
#define LQSScore @"score"
#define LQSUid @"uid"
#define LQSUserName @"userName"
#define LQSAvatar @"avatar"
#define LQSGender @"gender"
#define LQSUserTitle @"userTitle"
#define LQSRepeatList @"repeatList"
#define LQSVerify @"verify"
#define LQSCredits @"credits"
#define LQSExtcredits2 @"extcredits2"
#define LQSMobile @"mobile"
#define LQSVersion @"version"
#define LQSExternInfo @"externInfo"
#define LQSPadding @"padding"
#define LQSIsValidation @"isValidation"

#define LQSTR(string) string == nil?@"":string//字符串容错宏
#define KLQScreenFrameSize ([UIScreen mainScreen].applicationFrame.size)//屏幕尺寸
#define KSingleLine_Width 1.0f/([UIScreen mainScreen].scale)//1像素线宽的宏。
#define LQSgetwidth(w) w*([UIScreen mainScreen].applicationFrame.size.width)/750 //1334*750 适用于iPhone6s上的图片转换
#define LQSgetHeight(h) h*([UIScreen mainScreen].applicationFrame.size.height)/1134 //适用于iPhone6s上的图片转换

#endif /* LQSCommonDefine_h */
/*
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
 */

