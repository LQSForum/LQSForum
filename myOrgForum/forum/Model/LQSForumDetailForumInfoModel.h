//
//  LQSForumDetailForumInfoModel.h
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSForumDetailForumInfoModel : NSObject

@property (nonatomic, assign) NSInteger fid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) NSInteger tdPostsNum;
@property (nonatomic, assign) NSInteger postsTotalNum;
@property (nonatomic, assign) NSInteger topicTotalNum;
@property (nonatomic, assign) bool isFocus;

@end

@interface LQSForumDetailTopModel : NSObject

@property (nonatomic, assign) NSInteger fid;
@property (nonatomic, strong) NSString *title;

@end

@interface LQSForumDetailListModel : NSObject

@property (nonatomic, assign) NSInteger essence;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *userAvatar;
@property (nonatomic, strong) NSArray *verify;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger replies;
@property (nonatomic, assign) NSInteger top;
@property (nonatomic, assign) NSInteger isHasRecommendAdd;
@property (nonatomic, assign) NSInteger hits;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, assign) NSInteger hot;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) double lastReplyDate;
@property (nonatomic, strong) NSString *picPath;
@property (nonatomic, assign) NSInteger topicId;
@property (nonatomic, strong) NSString *userTitle;
@property (nonatomic, strong) NSString *sourceWebUrl;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, assign) NSInteger vote;
@property (nonatomic, strong) NSString *ratio;
@property (nonatomic, assign) NSInteger special;
@property (nonatomic, assign) NSInteger boardId;
@property (nonatomic, assign) NSInteger recommendAdd;
@property (nonatomic, strong) NSString *boardName;

- (NSString *)last_posts_date;

@end