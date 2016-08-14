//
//  LQSCishanModel.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/12.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSCishanModel.h"

@implementation LQSCishanModel

@end
@implementation LQSCishanListModel

- (NSString *)last_reply_date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdTime = [fmt dateFromString:self.last_reply_date];
    NSDateComponents *cmps = [createdTime deltaWithNow];
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
