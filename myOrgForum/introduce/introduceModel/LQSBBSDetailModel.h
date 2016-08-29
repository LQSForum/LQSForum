//
//  LQSBBSDetailModel.h
//  myOrgForum
//  功能 ： 论坛详情页用到的model
//  Created by 徐经纬 on 16/8/23.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSBBSDetailModel : NSObject
@property (nonatomic, strong) NSString *topic_id;//帖子ID
@property (nonatomic, strong) NSString *title;//贴纸标题
@property (nonatomic, strong) NSString *type; //
@property (nonatomic, strong) NSString *user_id; //发帖人ID
@property (nonatomic, strong) NSString *user_nick_name;//发帖人昵称
@property (nonatomic, strong) NSString *replies; //  y
@property (nonatomic, strong) NSString *hits;//浏览量 y
@property (nonatomic, strong) NSString *vote; //支持量
@property (nonatomic, strong) NSString *hot; // y
@property (nonatomic, strong) NSString *top;//置顶？
@property (nonatomic, strong) NSString *is_favor;//收藏量
@property (nonatomic, strong) NSString *create_date;//创建时间
@property (nonatomic, strong) NSString *icon;//发帖者头像 y
@property (nonatomic, strong) NSString *level;  //  y
@property (nonatomic, strong) NSString *userTitle;
@property (nonatomic, strong) NSString *isFollow;//?量 y
@property (nonatomic, strong) NSString *mobileSign;//"来自龙泉论坛手机客户端"
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *reply_posts_id;
@property (nonatomic, strong) NSString *essence;//精华帖 1，普通贴 0 y
@property (nonatomic, strong) NSString *page; //1
@property (nonatomic, strong) NSString *has_next;
@property (nonatomic, strong) NSString *total_num;// 13
@property (nonatomic, strong) NSArray *zanList;
@property (nonatomic, strong) NSArray *content;//帖子内容
@property (nonatomic, strong) NSArray *list; //回复列表
@property (nonatomic, strong) NSString *forumName;//“银杏树下”所在版名
@property (nonatomic, strong) NSString *boardId;//所在版号
@property (nonatomic, strong) NSString *forumTopicUrl;//浏览器论坛URL
@property (nonatomic, strong) NSString *interAct1;
@property (nonatomic, strong) NSString *interAct1Count;
@property (nonatomic, strong) NSString *interAct2;
@property (nonatomic, strong) NSString *interAct2Count;
@property (nonatomic, strong) NSString *interAct3;
@property (nonatomic, strong) NSString *interAct3Count;



@end

@interface LQSBBSPosterMOdel : NSObject

@property (nonatomic, strong) NSString *reply_id;
@property (nonatomic, strong) NSArray *reply_content;
@property (nonatomic, strong) NSString *reply_type;
@property (nonatomic, strong) NSString *reply_name;
@property (nonatomic, strong) NSString *reply_posts_id;
@property (nonatomic, strong) NSString *position;//楼层
@property (nonatomic, strong) NSString *posts_date;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *userTitle;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *mobileSign;
@property (nonatomic, strong) NSString *reply_status;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *role_num;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *is_quote;
@property (nonatomic, strong) NSString *quote_pid;
@property (nonatomic, strong) NSString *quote_content;
@property (nonatomic, strong) NSString *quote_user_name;
@property (nonatomic, strong) NSString *delThread;
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *
//@property (nonatomic, strong) NSString *


@end



@interface LQSBBSContentModel : NSObject

@property (nonatomic, strong) NSString *infor;//一段帖子内容 或者 图片URL
@property (nonatomic, strong) NSString *type; //0 帖子内容？ 1 图片URL？
@property (nonatomic, strong) NSString *originalInfo;//不造是啥
@property (nonatomic, strong) NSString *aid;//136076 不造是啥

@end

@interface LQSBBSModel : NSObject
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSArray *topic;
@property (nonatomic, strong) NSString *total_num;
@property (nonatomic, strong) NSString *list;
@property (nonatomic, strong) NSString *forumName;
@property (nonatomic, strong) NSString *boardId;
@property (nonatomic, strong) NSString *forumTopicUrl;
@property (nonatomic, strong) NSString *img_url;
@property (nonatomic, strong) NSString *icon_url;
@end




