//
//  LQSSelectPlatesDataModel.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/9/7.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSSelectPlatesDataModel : NSObject
@property (nonatomic, strong) NSString *board_category_id;
@property (nonatomic, strong) NSString *board_category_name;
@property (nonatomic, strong) NSString *board_category_type;
@property (nonatomic, strong) NSArray *board_list;


@end

@interface LQSSelectPlatesDetailDataModel : NSObject
@property (nonatomic, strong) NSString *board_id;
@property (nonatomic, strong) NSString *board_name;
//@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *board_child;
@property (nonatomic, strong) NSString *board_img;
@property (nonatomic, strong) NSString *last_posts_date;
@property (nonatomic, strong) NSString *board_content;
@property (nonatomic, strong) NSString *forumRedirect;
@property (nonatomic, strong) NSString *favNum;
@property (nonatomic, strong) NSString *td_posts_num;
@property (nonatomic, strong) NSString *topic_total_num;
@property (nonatomic, strong) NSString *posts_total_num;
@property (nonatomic, strong) NSString *is_focus;

@end