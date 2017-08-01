//
//  LQSUserRequest.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseRestRequest.h"
#import "LQSUserInfo.h"

@interface LQSUserRequest : LQSBaseRestRequest

- (void)registerUserByEmail:(NSString *)email withPWD:(NSString *)password withUserName:(NSString *)username completionBlock:(resultBlock)block;

- (void)updateUserByGender:(LQSTypeGender)gender withAvatarUrl:(NSString *)avatarUrl withUserName:(NSString *)username completionBlock:(resultBlock)block;

- (void)loginUserByUsername:(NSString *)username withPWD:(NSString *)password completionBlock:(resultBlock)block;

- (void)logoutUserByUsername:(NSString *)username withPWD:(NSString *)password completionBlock:(resultBlock)block;
@end
