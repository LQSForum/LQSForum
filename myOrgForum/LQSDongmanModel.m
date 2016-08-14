//
//  LQSDongmanModel.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/12.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSDongmanModel.h"

@implementation LQSDongmanModel

@end
@implementation LQSDongmanListModel
- (NSString *)last_reply_date
{
    
    //    _created_at = @"Tue Jun 12 07:46:55 +0800 2014";
    
    // 1.获得微博的创建时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // Tue May 31 17:46:55 +0800 2011
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
#warning 真机调试的时候必须加上(说明时间格式所属的区域)
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // _created_at(NSString) -> createdTime(NSDate)
    // 将字符串(NSString)转成时间对象(NSDate), 方便进行日期处理
    NSDate *createdTime = [fmt dateFromString:_last_reply_date];
    
    // 2.比较当前时间 和 微博的创建时间
    NSDateComponents *cmps = [createdTime deltaWithNow];
    
    // 3.根据差距, 返回对应的字符串
    if ([createdTime isThisYear]) { // 今年
        if ([createdTime isToday]) { // 今天
            if (cmps.hour >= 1) { // 至少1个小时前发的
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) { // 1 ~ 60分钟内发的
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if ([createdTime isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createdTime];
        } else { // 至少是前天发的
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createdTime];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdTime];
    }
}

@end
