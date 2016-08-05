//
//  LQSBaseModel_Private.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseModel.h"

@interface LQSBaseModel ()

@property (nonatomic, strong) NSMutableArray *ignores;

+ (instancetype)model:(id)dict;

- (NSMutableDictionary *)dictionary;

- (void)copyFromModel:(LQSBaseModel *)model;

@end
