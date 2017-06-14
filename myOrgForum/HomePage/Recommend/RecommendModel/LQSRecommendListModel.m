//
//  LQSRecommendListModel.m
//  myOrgForum
//
//  Created by wangbo on 2017/6/11.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSRecommendListModel.h"

@implementation LQSRecommendListModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    
    if (self ) {
        _essence = LQSTR(dictionary[@"essence"]);
        _status = LQSTR(dictionary[@"status"]);
        _title = LQSTR(dictionary[@"title"]);
        _userAvatar = LQSTR(dictionary[@"userAvatar"]);
        _replies = LQSTR(dictionary[@"replies"]);
        _user_id = LQSTR(dictionary[@"user_id"]);
        _top = LQSTR(dictionary[@"top"]);
        
        _imageList = dictionary[@"imageList"];//
        _videoList = dictionary[@"videoList"];
        
        _hits = LQSTR(dictionary[@"hits"]);
        _isHasRecommendAdd = LQSTR(dictionary[@"isHasRecommendAdd"]);
        _subject = LQSTR(dictionary[@"subject"]);
        _hot = LQSTR(dictionary[@"hot"]);
        
        _verify = dictionary[@"verify"];
        
        _type = LQSTR(dictionary[@"type"]);
        _gender = LQSTR(dictionary[@"gender"]);
        _last_reply_date = LQSTR(dictionary[@"last_reply_date"]);
        _pic_path = LQSTR(dictionary[@"pic_path"]);
        _topic_id = LQSTR(dictionary[@"topic_id"]);
        _userTitle = LQSTR(dictionary[@"userTitle"]);
        _sourceWebUrl = LQSTR(dictionary[@"sourceWebUrl"]);
        _user_nick_name = LQSTR(dictionary[@"user_nick_name"]);
        _vote = LQSTR(dictionary[@"vote"]);
        _isTopic = LQSTR(dictionary[@"isTopic"]);
        _ratio = LQSTR(dictionary[@"ratio"]);
        _special = LQSTR(dictionary[@"special"]);
        _board_id = LQSTR(dictionary[@"board_id"]);
        _recommendAdd = LQSTR(dictionary[@"recommendAdd"]);
        _board_name = LQSTR(dictionary[@"board_name"]);
    }
    
    return self;
}

@end
