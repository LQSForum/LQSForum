//
//  LQSBBSDetailModel.m
//  myOrgForum
//  功能 ： 论坛详情页用到的model
//  Created by 徐经纬 on 16/8/23.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBBSDetailModel.h"

@implementation LQSBBSDetailModel
- (void) setContent:(NSArray *)content
{
    if ( _content != content) {
        _content = [[NSArray alloc] initWithArray:content];
    }
}
@end

@implementation LQSBBSPosterMOdel

@end

@implementation LQSBBSContentModel

@end

@implementation LQSBBSModel

@end
