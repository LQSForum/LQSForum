//
//  LQSForumDetailForumInfoModel.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailForumInfoModel.h"

@implementation LQSForumDetailForumInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"fid":@"id",
             @"desc":@"description",
             @"tdPostsNum":@"td_posts_num",
             @"postsTotalNum":@"posts_total_num",
             @"topicTotalNum":@"topic_total_num",
             @"isFocus":@"is_focus"};
}

@end

@implementation LQSForumDetailTopModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"fid":@"id"};
}

@end

@implementation LQSForumDetailListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"essence":@"essence",
             @"status":@"status",
             @"userAvatar":@"userAvatar",
             @"verify":@"verify",
             @"imageList":@"imageList",
             @"userId":@"user_id",
             @"title":@"title",
             @"replies":@"replies",
             @"top":@"top",
             @"isHasRecommendAdd":@"isHasRecommendAdd",
             @"hits":@"hits",
             @"subject":@"subject",
             @"hot":@"hot",
             @"type":@"type",
             @"gender":@"gender",
             @"lastReplyDate":@"last_reply_date",
             @"picPath":@"pic_path",
             @"topicId":@"topic_id",
             @"userTitle":@"userTitle",
             @"sourceWebUrl":@"sourceWebUrl",
             @"userNickName":@"user_nick_name",
             @"vote":@"vote",
             @"ratio":@"ratio",
             @"special":@"special",
             @"boardId":@"board_id",
             @"recommendAdd":@"recommendAdd",
             @"boardName":@"board_name"};
}

@end