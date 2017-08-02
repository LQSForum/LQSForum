//
//  LQSForumAttentionModel.m
//  myOrgForum
//
//  Created by 昱含 on 2017/5/11.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSForumAttentionModel.h"

@implementation LQSForumAttentionModel
// 返回一个Dict，将Model属性名对映射到JSON的Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"attentionBoardID" :@"board_id",
             @"attentionBoardName" :@"board_name",
             @"attentionEssence" :@"essence",
             @"attentionTopicID" : @"topic_id",
             @"attentionType" :@"type",
             @"attentionTitle" :@"title",
             @"attentionSubject" :@"subject",
             @"attentionIsTopic" :@"isTopic",
             @"attentionUserID" :@"user_id",
             @"attentionUserName" :@"user_nick_name",
             @"attentionUserIcon" :@"userAvatar",
             @"attentionUserGender" :@"gender",
             @"attentionReplyDate" :@"last_reply_date",
             @"attentionVote" :@"vote",
             @"attentionHot" :@"hot",
             @"attentionReadNum" :@"hits",
             @"attentionCommentNum" :@"replies",
             @"attentionTop" :@"top",
             @"attentionPictureList" :@"imageList"
             };
}
@end
