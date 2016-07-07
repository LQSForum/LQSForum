//
//  LQSForumModel.m
//  myOrgForum
//
//  Created by 昱含 on 16/7/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSectionModel.h"

@implementation LQSSectionModel
- (NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end
