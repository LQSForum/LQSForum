
//
//  LQSPhoto.m
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPhoto.h"

@implementation LQSPhoto
- (NSString *)bmiddle_pic
{
    return [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
