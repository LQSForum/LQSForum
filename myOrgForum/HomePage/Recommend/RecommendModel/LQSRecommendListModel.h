//
//  LQSRecommendListModel.h
//  myOrgForum
//
//  Created by wangbo on 2017/6/11.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

//TODO: 后期改为JSONModel比较好些
@interface LQSRecommendListModel : NSObject

//@property (nonatomic, assign) NSInteger essence;
@property (nonatomic, strong) NSString *essence;
//@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *userAvatar;
//@property (nonatomic, assign) NSInteger replies;
@property (nonatomic, strong) NSString *replies;
@property (nonatomic, strong) NSString *user_id;
//@property (nonatomic, assign) NSInteger top;
@property (nonatomic, strong) NSString *top;
@property (nonatomic, strong) NSMutableArray *imageList;
@property (nonatomic, strong) NSMutableArray *videoList;
//@property (nonatomic, assign) NSInteger hits;
@property (nonatomic, strong) NSString *hits;
//@property (nonatomic, assign) NSInteger isHasRecommendAdd;
@property (nonatomic, strong) NSString *isHasRecommendAdd;
@property (nonatomic, strong) NSString *subject;
//@property (nonatomic, assign) NSInteger hot;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSMutableArray *verify;
@property (nonatomic, strong) NSString *type;
//@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *last_reply_date;
@property (nonatomic, strong) NSString *pic_path;
//@property (nonatomic, assign) NSInteger topic_id;
@property (nonatomic, strong) NSString *topic_id;
@property (nonatomic, strong) NSString *userTitle;
@property (nonatomic, strong) NSString *sourceWebUrl;
@property (nonatomic, strong) NSString *user_nick_name;
//@property (nonatomic, assign) NSInteger vote;
@property (nonatomic, strong) NSString *vote;
//@property (nonatomic, assign) NSInteger isTopic;
@property (nonatomic, strong) NSString *isTopic;
@property (nonatomic, strong) NSString *ratio;
//@property (nonatomic, assign) NSInteger special;
@property (nonatomic, strong) NSString *special;
//@property (nonatomic, assign) NSInteger board_id;
@property (nonatomic, strong) NSString *board_id;
//@property (nonatomic, assign) NSInteger recommendAdd;
@property (nonatomic, strong) NSString *recommendAdd;
@property (nonatomic, strong) NSString *board_name;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

/**
 {
 "essence" : 1,
 "status" : 0,
 "title" : "北京十三陵为爱行走大型公益活动图片纪实",
 "userAvatar" : "http:\/\/forum.longquanzs.org\/uc_server\/avatar.php?uid=198890&size=middle",
 "replies" : 5,
 "user_id" : 198890,
 "top" : 0,
 "imageList" : [
 "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/092323zo8uoc2a3uof8oar.jpg.thumb.jpg",
 "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/095525w00k00wnb5p75257.jpg.thumb.jpg",
 "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/095536ux6xhb0lk6k0ffkz.jpg.thumb.jpg",
 "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/095600nveapb71zmfighgm.jpg.thumb.jpg",
 "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/095635pwwwtnnppii0nwhz.jpg.thumb.jpg",
 "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/095618zgqnnj410x0wxqig.jpg.thumb.jpg",
 "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/095651qn2xxxw1wn2nm292.jpg.thumb.jpg",
 "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/095713shgh02bf1guhigsh.jpg.thumb.jpg",
 "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/103359t8x9mn6l6o6jr2yj.jpg.thumb.jpg"
 ],
 "videoList" : [
 
 ],
 "hits" : 897,
 "isHasRecommendAdd" : 0,
 "subject" : "     2017年6月10日，近千名志愿者参加了在北京",
 "hot" : 0,
 "verify" : [
 
 ],
 "type" : "normal",
 "gender" : 1,
 "last_reply_date" : "1497173448000",
 "pic_path" : "http:\/\/forum.longquanzs.org\/data\/attachment\/forum\/201706\/11\/092323zo8uoc2a3uof8oar.jpg.thumb.jpg",
 "topic_id" : 90449,
 "userTitle" : "金牌会员",
 "sourceWebUrl" : "http:\/\/forum.longquanzs.org\/forum.php?mod=viewthread&tid=90449",
 "user_nick_name" : "正在Z",
 "vote" : 0,
 "isTopic" : 0,
 "ratio" : "1",
 "special" : 0,
 "board_id" : 259,
 "recommendAdd" : 0,
 "board_name" : "仁爱慈善"
 },
 */
