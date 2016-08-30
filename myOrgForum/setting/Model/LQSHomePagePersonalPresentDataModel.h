//
//  LQSHomePagePersonalPresentDataModel.h
//  myOrgForum
//
//  Created by 周双 on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSHomePagePersonalPresentDataModel : NSObject

@property (nonatomic,strong)NSString *rs;
@property (nonatomic,strong)NSString *errcode;
@property (nonatomic, strong) NSString *_total_num;

@end
@interface LQSHomePagePersonalPresentDatailDataModel : NSObject

@property (nonatomic,strong)NSString *imageList;
@property (nonatomic,strong)NSString *board_id;
@property (nonatomic,strong)NSString *board_name;
@property (nonatomic,strong)NSString *topic_id;
@property (nonatomic,strong)NSString *type_id;
@property (nonatomic,strong)NSString *sort_id;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *subject;
@property (nonatomic,strong)NSString *user_id;
@property (nonatomic,strong)NSString *last_reply_date;
@property (nonatomic,strong)NSString *user_nick_name;
@property (nonatomic,strong)NSString *hits;
@property (nonatomic,strong)NSString *replies;
@property (nonatomic,strong)NSString *top;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *essence;
@property (nonatomic,strong)NSString *hot;
@property (nonatomic,strong)NSString *userAvatar;
@property (nonatomic,strong)NSString *special;


@end
