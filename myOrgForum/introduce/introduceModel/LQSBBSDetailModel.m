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
//    LQSBBSDetailTopicModel *model = [[LQSBBSDetailTopicModel alloc]init];
    [self setValuesForKeysWithDictionary:dict];
//    return model;
    if (nil != [dict objectForKey:@"content"]) {
        NSArray  *contenArr = [LQSBBSContentModel mj_objectArrayWithKeyValuesArray:[dict[@"topic"] objectForKey:@"content"]];
        self.content = [NSMutableArray arrayWithArray:contenArr];
        NSLog(@"arr: %@",contenArr);
    }
    if (nil != [dict objectForKey:@"zanList"]) {
        NSArray  *zanListArr = [LQSBBSContentModel mj_objectArrayWithKeyValuesArray:[dict[@"topic"] objectForKey:@"zanList"]];
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
