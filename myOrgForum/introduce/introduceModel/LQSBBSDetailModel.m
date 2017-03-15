//
//  LQSBBSDetailModel.m
//  myOrgForum
//  功能 ： 论坛详情页用到的model
//  Created by 徐经纬 on 16/8/23.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBBSDetailModel.h"
#import "LQSAddViewHelper.h"
@implementation LQSBBSDetailModel
//- (void) setContent:(NSArray *)content
//{
//    if ( _content != content) {
//        _content = [[NSMutableArray alloc] initWithArray:content];
//    }
//}
// 复制粘贴的LQSLateastMarrowModel的时间戳转换
@end
@implementation LQSBBSDetailTopicModel

- (NSString *)create_date
{
    return [LQSAddViewHelper createDataDescriptionWithStr:_create_date];
}
-(void)ModelWithDict:(NSDictionary *)dict{

//    [self setValuesForKeysWithDictionary:dict];
    self.hits = LQSTR(dict[@"hits"]);
    self.icon = LQSTR(dict[@"icon"]);
    self.level = LQSTR(dict[@"level"]);
    self.replies = LQSTR(dict[@"replies"]);
    self.isFollow = [dict[@"isFollow"] integerValue];
    self.hot = LQSTR(dict[@"hot"]);
    self.essence = dict[@"essence"];

    self.reply_status = LQSTR(dict[@"reply_status"]);
    self.flag = LQSTR(dict[@"flag"]);
    self.vote = LQSTR(dict[@"vote"]);
    self.type = LQSTR(dict[@"type"]);
    self.create_date = LQSTR(dict[@"create_date"]);
    self.is_favor = LQSTR(dict[@"is_favor"]);
    self.top = LQSTR(dict[@"top"]);
    self.status = LQSTR(dict[@"status"]);
    self.user_nick_name = LQSTR(dict[@"user_nick_name"]);
    self.user_id = LQSTR(dict[@"user_id"]);
    self.userTitle = LQSTR(dict[@"userTitle"]);
    self.gender = LQSTR(dict[@"gender"]);
    self.mobileSign = LQSTR(dict[@"mobileSign"]);
    self.reply_posts_id = LQSTR(dict[@"reply_posts_id"]);
    self.title = LQSTR(dict[@"title"]);
    self.forumTopicUrl = LQSTR(dict[@"forumTopicUrl"]);
    self.page = LQSTR(dict[@"page"]);
    if (nil != [dict objectForKey:@"content"]) {
        NSArray  *contenArr = [LQSBBSContentModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"content"]];
        self.content = [NSMutableArray arrayWithArray:contenArr];
        NSLog(@"arr: %@",contenArr);
    }
    if (nil != [dict objectForKey:@"zanList"]) {
        NSArray  *zanListArr = [LQSBBSContentModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"zanList"]];
        self.zanList = [NSMutableArray arrayWithArray:zanListArr];
    }
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"LQSBBSDetailTopicModel.forUndefinedKey:%@",key);
}
@end

@implementation LQSBBSPosterModel
-(NSString *)posts_date{

    return [LQSAddViewHelper createDataDescriptionWithStr:_posts_date];
}
-(void)modelWithDict:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"posterModel.undefinedKey:%@",key);
}
@end

@implementation LQSBBSContentModel

@end

@implementation LQSBBSModel

@end
