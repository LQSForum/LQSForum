//
//  LQSTitleModel.h
//  myOrgForum
//
//  Created by 昱含 on 16/7/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSCellModel : NSObject

@property (nonatomic, assign) NSInteger board_child;
@property (nonatomic, assign) NSInteger board_content;
@property (nonatomic, assign) NSInteger board_id;
@property (nonatomic, copy) NSString *board_img;
@property (nonatomic, copy) NSString *board_name;
//@property (nonatomic, copy) NSString *description;
@property (nonatomic, assign) NSInteger favNum;
@property (nonatomic, copy) NSString *last_posts_date;
@property (nonatomic, assign) NSInteger posts_total_num;
@property (nonatomic, assign) NSInteger td_posts_num;
@property (nonatomic, assign) NSInteger topic_total_num;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@end
