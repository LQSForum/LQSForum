//
//  LQSDiscoverModel.h
//  myOrgForum
//
//  Created by g x on 2017/7/27.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSDiscoverModel : NSObject
@property (nonatomic,strong)NSString * rs;
@property (nonatomic,strong)NSString * errcode;
@property (nonatomic,strong)NSString * page;
@property (nonatomic,strong)NSString *   has_next;
@property (nonatomic, strong) NSString *total_num;

@end

@interface LQSDiscoverListModel : NSObject

@property (nonatomic,assign)NSInteger board_id;
@property (nonatomic,strong)NSString *board_name;// 所属类别
@property (nonatomic,assign)NSInteger topic_id;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *title;// cell标题
@property (nonatomic,assign)NSInteger isTopic;
@property (nonatomic,assign)NSInteger user_id;
@property (nonatomic,strong)NSString *user_nick_name;// 发布者昵称
@property (nonatomic,strong)NSString *userAvatar;
@property (nonatomic,strong)NSString *last_reply_date;// 最近的回复时间
@property (nonatomic,assign)NSInteger vote;
@property (nonatomic,assign)NSInteger hot;
@property (nonatomic,assign)NSInteger hits;// 阅读量
@property (nonatomic,assign)NSInteger replies;//回复数量，这个在app上没显示
@property (nonatomic,assign)NSInteger essence;
@property (nonatomic,assign)NSInteger top;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *subject;// 副标题，内容
@property (nonatomic,strong)NSString *pic_path;
@property (nonatomic,strong)NSString *ratio;
@property (nonatomic,assign)NSInteger gender;
@property (nonatomic,strong)NSString *userTitle;
@property (nonatomic,assign)NSInteger recommendAdd;
@property (nonatomic,assign)NSInteger special;
@property (nonatomic,assign)NSInteger isHasRecommendAdd;
@property (nonatomic,strong)NSArray *imageList;// 保存图片的数组,在cell中最多展示三个。
@property (nonatomic,strong)NSString *sourceWebUrl;
@property (nonatomic,strong)NSArray *videoList;
@property (nonatomic,strong)NSArray *verify;

@property (nonatomic,assign)CGFloat cellheight;// 记录cell的高度

@end
