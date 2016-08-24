//
//  LQSBBSDetailModel.h
//  myOrgForum
//
//  Created by XJW on 16/8/23.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSBBSDetailModel : NSObject
@property (nonatomic, strong) NSString *topic_id;//帖子ID
@property (nonatomic, strong) NSString *title;//贴纸标题
@property (nonatomic, strong) NSString *type; //
@property (nonatomic, strong) NSString *user_id; //发帖人ID
@property (nonatomic, strong) NSString *user_nick_name;//发帖人昵称
@property (nonatomic, strong) NSString *replies; //
@property (nonatomic, strong) NSString *hits;//点击？
@property (nonatomic, strong) NSString *vote;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *top;
@property (nonatomic, strong) NSString *is_favor;
@property (nonatomic, strong) NSString *create_date;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *userTitle;
@property (nonatomic, strong) NSString *isFollow;
@property (nonatomic, strong) NSArray *zanList;
@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSString *mobileSign;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *reply_posts_id;
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *




@end

@interface LQSBBSPosterMOdel : NSObject

@end



