//
//  LQSPhoto.h
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSPhoto : NSObject
/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail_pic;

/** 中等图 */
- (NSString *)bmiddle_pic;

@end
