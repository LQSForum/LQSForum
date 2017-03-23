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
    // 下面的这段暂时不注释掉了，因为不知道原来是干嘛用的，而且这个zanlist好像没什么用处。
    if (nil != [dict objectForKey:@"zanList"]) {
        NSArray  *zanListArr = [LQSBBSContentModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"zanList"]];
        self.zanList = [NSMutableArray arrayWithArray:zanListArr];
    }
    // 这里拿到数据中的reward字典，直接解析，把有用的提取出来，添加到model中，没用的不必存储。
    NSDictionary *rewardDic = dict[@"reward"];
    self.daShangRenShu = [rewardDic[@"userNumber"] integerValue];
    self.showAllUrl = LQSTR(rewardDic[@"showAllUrl"]);
    // 获取字典中的score数组，读取打赏的内容
    NSArray *scoreArr = rewardDic[@"score"];
    NSMutableAttributedString *numAttriStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%zd",self.daShangRenShu] attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    [numAttriStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"人共打赏 "]];
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc]init];
    for (NSDictionary *dashangDict in scoreArr) {
        NSMutableAttributedString *valueAttriStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%zd",[dashangDict[@"value"] integerValue]] attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
        [tempStr appendAttributedString:valueAttriStr];
        [tempStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",dashangDict[@"info"]]
         ]];
    }
    if (!self.daShangInfoStr) {
        self.daShangInfoStr = [[NSMutableAttributedString alloc]init];
    }
    [self.daShangInfoStr appendAttributedString:numAttriStr];
    [self.daShangInfoStr appendAttributedString:tempStr];
    //  获取打赏用户的头像URL
    for (NSDictionary *userInfoDict in rewardDic[@"userList"]) {
        if (!self.dashangIconArr) {
            self.dashangIconArr = [NSMutableArray array];
        }
        daShangRenInfoModel *model = [[daShangRenInfoModel alloc]init];
        model.userIcon = userInfoDict[@"userIcon"];
        model.userName = userInfoDict[@"userName"];
        model.uid = [userInfoDict[@"uid"] stringValue];
        [self.dashangIconArr addObject:model];
    }
    // 获取大赏的网页url
    NSArray *extraPanel = dict[@"extraPanel"];
    for (NSDictionary *innerDict in extraPanel) {
        // 这里还是先不用这个字段作为判断了，因为不知道它这个字段有什么用处，万一以后改了，就很麻烦。
//        if ([innerDict[@"title"] isEqualToString:@"评分"]) {
            self.dashangWebUrl = innerDict[@"action"];
             NSLog(@"拿到了大赏页的URL:%@",self.dashangWebUrl);
//        }
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

@implementation daShangRenInfoModel



@end
