//
//  LQSDongmanModel.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/12.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSDongmanModel : NSObject
@property (nonatomic,strong)NSString * rs;
@property (nonatomic,strong)NSString * errcode;
@property (nonatomic,strong)NSArray * piclist;
@property (nonatomic,strong)NSString * page;
@property (nonatomic,strong)NSString *   has_next;
@property (nonatomic, strong) NSString *total_num;

@end
@interface LQSDongmanListModel : NSObject
@property (nonatomic,strong)NSString * special;
@property (nonatomic,strong)NSString * fid;
@property (nonatomic,strong)NSArray * board_id;
@property (nonatomic,strong)NSString * board_name;
@property (nonatomic,strong)NSString *   source_type;
@property (nonatomic, strong) NSString *source_id;
@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * user_id;
@property (nonatomic,strong)NSArray * last_reply_date;
@property (nonatomic,strong)NSString * user_nick_name;
@property (nonatomic,strong)NSString *   hits;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic,strong)NSString * replies;
@property (nonatomic,strong)NSString * pic_path;
@property (nonatomic,strong)NSArray * ratio;
@property (nonatomic,strong)NSString * redirectUrl;
@property (nonatomic,strong)NSString *   userAvatar;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *recommendAdd;
@property (nonatomic,strong)NSString * isHasRecommendAdd;
@property (nonatomic,strong)NSArray * distance;
@property (nonatomic,strong)NSString * location;
@property (nonatomic,strong)NSString *   imageList;
@property (nonatomic, strong) NSString *sourceWebUrl;
@property (nonatomic, strong) NSString *verify;
@end
