//
//  LQSForumDetailForumInfoModel.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailForumInfoModel.h"

@implementation LQSForumDetailForumInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"fid":@"id",
             @"desc":@"description",
             @"tdPostsNum":@"td_posts_num",
             @"postsTotalNum":@"posts_total_num",
             @"topicTotalNum":@"topic_total_num",
             @"isFocus":@"is_focus"};
}

@end

@implementation LQSForumDetailTopModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"fid":@"id"};
}

@end

@implementation LQSForumDetailListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"essence":@"essence",
             @"status":@"status",
             @"userAvatar":@"userAvatar",
             @"verify":@"verify",
             @"imageList":@"imageList",
             @"userId":@"user_id",
             @"title":@"title",
             @"replies":@"replies",
             @"top":@"top",
             @"isHasRecommendAdd":@"isHasRecommendAdd",
             @"hits":@"hits",
             @"subject":@"subject",
             @"hot":@"hot",
             @"type":@"type",
             @"gender":@"gender",
             @"lastReplyDate":@"last_reply_date",
             @"picPath":@"pic_path",
             @"topicId":@"topic_id",
             @"userTitle":@"userTitle",
             @"sourceWebUrl":@"sourceWebUrl",
             @"userNickName":@"user_nick_name",
             @"vote":@"vote",
             @"ratio":@"ratio",
             @"special":@"special",
             @"boardId":@"board_id",
             @"recommendAdd":@"recommendAdd",
             @"boardName":@"board_name"};
}
- (NSString *)last_posts_date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    //时间戳转换
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:self.lastReplyDate/ 1000];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    //    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    
    if ([createDate isThisYear]) { // 今年
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            //            fmt.dateFormat = @"MM-dd HH:mm";
            //            return [fmt stringFromDate:createDate];
            return [NSString stringWithFormat:@"%ld天前",(long)cmps.day];
        }
    } else { // 非今年
        //        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return @"暂无内容";
    }
}
@end