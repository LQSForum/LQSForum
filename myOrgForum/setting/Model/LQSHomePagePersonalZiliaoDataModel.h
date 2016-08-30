//
//  LQSHomePagePersonalZiliaoDataModel.h
//  myOrgForum
//
//  Created by 周双 on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LQSHomePagePersonalZiliaoDetailDataModel;
@class LQSHomePagePersonalZiliaoProfileListDataModel;
@interface LQSHomePagePersonalZiliaoDataModel : NSObject

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *is_black;
@property (nonatomic, strong) NSString *is_follow;
@property (nonatomic, strong) NSString *isFriend;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *level_url;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *credits;
@property (nonatomic, strong) NSString *gold_num;
@property (nonatomic, strong) NSString *topic_num;
@property (nonatomic, strong) NSString *photo_num;
@property (nonatomic, strong) NSString *reply_posts_num;
@property (nonatomic, strong) NSString *essence_num;
@property (nonatomic, strong) NSString *friend_num;
@property (nonatomic, strong) NSString *follow_num;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *userTitle;
@property (nonatomic, strong) NSString *verify;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *info;
//模型数组
@property (nonatomic, strong) NSArray *profileList;
@property (nonatomic, strong) NSArray *creditList;
@property (nonatomic, strong) NSArray *creditShowList;

@property (nonatomic, strong) NSDictionary *body;

@end


@interface LQSHomePagePersonalZiliaoDetailDataModel : NSObject

@property (nonatomic, strong) NSArray *ziliaoProfileArr;

@end

@interface LQSHomePagePersonalZiliaoProfileListDataModel : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *data;

@end