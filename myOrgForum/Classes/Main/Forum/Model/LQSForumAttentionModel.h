//
//  LQSForumAttentionModel.h
//  myOrgForum
//
//  Created by 昱含 on 2017/5/11.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSForumAttentionModel : NSObject
/** 版块ID */
@property (nonatomic, assign) NSInteger attentionBoardID;
/** 版块名称 */
@property (nonatomic, copy) NSString *attentionBoardName;
/** 是否为精华 */
@property (nonatomic, assign) NSInteger attentionEssence;
/** 主题 */
@property (nonatomic, copy) NSString *attentionTitle;
/** 摘要 */
@property (nonatomic, copy) NSString *attentionSubject;
/** 用户ID */
@property (nonatomic, assign) NSInteger attentionUserID;
/** 用户名称 */
@property (nonatomic, copy) NSString *attentionUserName;
/** 用户头像 */
@property (nonatomic, copy) NSString *attentionUserIcon;
/** 用户性别 */
@property (nonatomic, assign) NSInteger attentionUserGender;
/** 回复时间 */
@property (nonatomic, copy) NSString *attentionReplyDate;
/** 浏览量 */
@property (nonatomic, assign) NSInteger attentionReadNum;
/** 评论数 */
@property (nonatomic, assign) NSInteger attentionCommentNum;
/** 图片数组 */
@property (nonatomic, strong) NSArray *attentionPictureList;

/** 其他 */
@property (nonatomic, assign) NSInteger attentionIsTopic;
@property (nonatomic, assign) NSInteger attentionTopicID;
@property (nonatomic, assign) NSInteger attentionTop;
@property (nonatomic, assign) NSInteger attentionType;
@property (nonatomic, assign) NSInteger attentionVote;
@property (nonatomic, assign) NSInteger attentionHot;

@end
