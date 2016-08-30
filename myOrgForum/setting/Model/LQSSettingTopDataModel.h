//
//  LQSSettingTopDataModel.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSSettingTopDataModel : NSObject
@property (nonatomic, copy) NSString *icon;//头像
//用户名
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *gender;//性别

//积分
@property (nonatomic, copy) NSString *score;
//香花
@property (nonatomic, copy) NSString *credits;
@property (nonatomic, copy) NSString *userTitle;//用户描述吧!


@end
