//
//  LQSLastestMarrowModel.h
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSLastestMarrowModel : NSObject

@property (nonatomic, assign) NSInteger replies;
@property (nonatomic, copy) NSString *board_name;
@property (nonatomic, copy) NSString *pic_path;
@property (nonatomic, copy) NSString *last_reply_date;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *board_list;
@property (nonatomic, copy) NSString *user_nick_name;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSInteger essence;

@end

