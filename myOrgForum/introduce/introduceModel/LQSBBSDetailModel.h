//
//  LQSBBSDetailModel.h
//  myOrgForum
//  功能 ： 论坛详情页用到的model
//  Created by 徐经纬 on 16/8/23.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSBBSDetailModel : NSObject
@property (nonatomic, strong) NSString *forumName;//“银杏树下”所在版名
@property (nonatomic, strong) NSString *rs;
@property (nonatomic, strong) NSString *total_num;// 13，表示总的评论数，用于在输入框的展示。
@property (nonatomic, strong) NSString *has_next;

@end
@interface LQSBBSDetailTopicModel : NSObject
@property (nonatomic, strong) NSString *hits;//浏览量 y
@property (nonatomic, strong) NSString *icon;//发帖者头像 y
@property (nonatomic, strong) NSString *level;  //  y
@property (nonatomic, strong) NSString *replies; //  y
@property (nonatomic, assign) NSInteger isFollow;//?量 y 0表示未关注,1表示已关注
@property (nonatomic, strong) NSString *hot; // y
@property (nonatomic, strong) NSNumber *essence;//精华帖 1，普通贴 0 y
@property (nonatomic, strong) NSString *reply_status;
@property (nonatomic, strong) NSString * flag;
@property (nonatomic, strong) NSString *vote; //支持量
@property (nonatomic, strong) NSString *type; //
@property (nonatomic, strong) NSString *create_date;//创建时间
@property (nonatomic, strong) NSString *is_favor;//收藏量
@property (nonatomic, strong) NSString *top;//置顶？
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *user_nick_name;//发帖人昵称
@property (nonatomic, strong) NSString *user_id; //发帖人ID
@property (nonatomic, strong) NSString *userTitle;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *mobileSign;//"来自龙泉论坛手机客户端"
@property (nonatomic, strong) NSString *reply_posts_id;
@property (nonatomic, strong) NSString *title;//贴纸标题
@property (nonatomic, strong) NSString *forumTopicUrl;//浏览器论坛URL
@property (nonatomic, strong) NSString *page; //1
@property (nonatomic, strong) NSArray *zanList;// 这个zanList里面并没有东西。打赏列表里面的是reward字段。
@property (nonatomic, strong) NSMutableAttributedString *daShangInfoStr; // 打赏的拼接好的内容，比如50微笑，如果将来还有别的，比如鲜花，就是拼接好的50微笑，20鲜花。他这个内容是以数组形式存储起来的，value：个数。info:打赏的种类。然后存在数组里面，可以做成结构体。或者直接解析都可以。这里直接解析出来，然后拼接好，提供给view展示。
@property (nonatomic,assign)NSInteger daShangRenShu;// 打赏的人数
@property (nonatomic,strong)NSMutableArray *dashangIconArr;// 打赏人们的头像URL数组。
@property (nonatomic,strong)NSString *showAllUrl; // 展示所有打赏人员的网页URL。
@property (nonatomic, strong) NSMutableArray *content;//帖子内容
- (void)ModelWithDict:(NSDictionary *)dict;
// 记录cell的高度
@property (nonatomic,assign)CGFloat topicCellHeight;

@end

//@property (nonatomic, strong) NSString *topic_id;//帖子ID


//@property (nonatomic, strong) NSMutableArray *list; //回复列表
//@property (nonatomic, strong) NSString *boardId;//所在版号
//@property (nonatomic, strong) NSMutableArray *rateList;//
//@property (nonatomic, strong) NSString *interAct1;
//@property (nonatomic, strong) NSString *interAct1Count;
//@property (nonatomic, strong) NSString *interAct2;
//@property (nonatomic, strong) NSString *interAct2Count;
//@property (nonatomic, strong) NSString *interAct3;
//@property (nonatomic, strong) NSString *interAct3Count;

/*
 rateList = {
 body = (
 {
     field3 = ;
     field2 = +10;
     field1 = 朱丽安;
 }
 ,
 {
     field3 = ;
     field2 = +10;
     field1 = 君宝;
 }
 ,
 );
 showAllUrl = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/ratelistview&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=&pid=331950;
 total = {
     field3 = ;
     field2 = 20;
     field1 = 2;
 };
 head = {
     field3 = ;
     field2 = 微笑;
     field1 = 参与人数;
 };
 };
 */


@interface LQSBBSPosterModel : NSObject //论坛回帖数据

@property (nonatomic, strong) NSString *reply_id;
@property (nonatomic, strong) NSMutableArray *reply_content;
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
// 缓存内容高度
@property (nonatomic,assign)CGFloat contentHeight;
-(void)modelWithDict:(NSDictionary *)dict;
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

@interface daShangRenInfoModel : NSObject
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *userIcon;
@property (nonatomic,strong)NSString *uid;// 用于跳转到用户的主页
@end


