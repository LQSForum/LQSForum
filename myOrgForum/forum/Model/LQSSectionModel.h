//
//  LQSForumModel.h
//  myOrgForum
//
//  Created by 昱含 on 16/7/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSSectionModel : NSObject

@property (nonatomic, assign) NSInteger board_category_id;
@property (nonatomic, copy) NSString *board_category_name;
@property (nonatomic, assign) NSInteger board_category_type;
@property (nonatomic, strong) NSArray *board_list;
@property (nonatomic, strong) NSMutableArray *items;

@end
