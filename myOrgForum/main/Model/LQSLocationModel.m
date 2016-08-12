//
//  LQSLocationModel.m
//  myOrgForum
//
//  Created by 宋小宇Mac pro on 16/8/10.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSLocationModel.h"

@implementation LQSLocationModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
