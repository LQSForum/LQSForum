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

- (void)setToken:(NSString *)token
{
    
}
- (NSString *)token
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:LQSToken];
    if (token.length > 0) {
        return token;
    }
    return @"";
}

- (NSString *)secret
{
    NSString *secret = [[NSUserDefaults standardUserDefaults] objectForKey:LQSSecret];
    if (secret.length > 0) {
        return secret;
    }
    return @"";
}

- (NSString *)score
{
    NSString *score = [[NSUserDefaults standardUserDefaults] objectForKey:LQSScore];
    if (score.length > 0) {
        return score;
    }
    return @"";
}
- (NSString *)uid
{
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:LQSUid];
    if (uid.length > 0) {
        return uid;
    }
    return @"";
}

- (NSString *)userName
{
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:LQSUserName];
    if (userName.length > 0) {
        return userName;
    }
    return @"";
}

- (NSString *)avatar
{
    NSString *avatar = [[NSUserDefaults standardUserDefaults] objectForKey:LQSAvatar];
    if (avatar.length > 0) {
        return avatar;
    }
    return avatar;
}

- (NSString *)gender
{
    NSString *gender = [[NSUserDefaults standardUserDefaults] objectForKey:LQSGender];
    if (gender.length > 0) {
        return gender;
    }
    return @"";
}

- (NSString *)userTitle
{
    NSString *title = [[NSUserDefaults standardUserDefaults] objectForKey:LQSUserTitle];
    if (title.length > 0) {
        return title;
    }
    return @"";
}

- (NSString *)repeatList
{
    NSString *list = [[NSUserDefaults standardUserDefaults] objectForKey:LQSRepeatList];
    if (list.length > 0) {
        return list;
    }
    return @"";
}

- (NSString *)verify
{
    NSString *verify = [[NSUserDefaults standardUserDefaults] objectForKey:LQSVerify];
    if (verify.length > 0) {
        return verify;
    }
    return verify;
}

- (NSString *)credits
{
    NSString *credits = [[NSUserDefaults standardUserDefaults]objectForKey:LQSCredits];
    if (credits.length > 0) {
        return credits;
    }
    return @"";
}

- (NSString *)extcredits2
{
    NSString *extcredits2 = [[NSUserDefaults standardUserDefaults]objectForKey:LQSExtcredits2];
    if (extcredits2.length > 0) {
        return extcredits2;
    }
    return @"";
}

-(NSString *)mobile
{
    NSString *mobile = [[NSUserDefaults standardUserDefaults] objectForKey:LQSMobile];
    if (mobile.length > 0) {
        return mobile;
    }
    return @"";
}

-(NSString *)version
{
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:LQSVersion];
    if (version.length > 0) {
        return version;
    }
    return @"";
}

- (NSString *)externInfo
{
    NSString *exterInfo = [[NSUserDefaults standardUserDefaults] objectForKey:LQSExternInfo];
    if (exterInfo.length > 0) {
        return exterInfo;
    }
    return @"";
}

- (NSString *)padding
{
    NSString *padding = [[NSUserDefaults standardUserDefaults] objectForKey:LQSPadding];
    if (padding.length > 0) {
        return  padding;
    }
    return @"";
}

- (NSString *)isValidation
{
    NSString *isVal = [[NSUserDefaults standardUserDefaults] objectForKey:LQSIsValidation];
    if (isVal.length > 0) {
        return isVal;
    }
    return @"";
}











@end












