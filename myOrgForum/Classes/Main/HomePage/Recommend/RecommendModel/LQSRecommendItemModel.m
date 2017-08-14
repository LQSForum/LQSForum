//
//  LQSRecommendItemModel.m
//  myOrgForum
//
//  Created by wangbo on 2017/7/16.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSRecommendItemModel.h"

@implementation LQSReItemExtParam

@end

@implementation LQSRecommendItemModel

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

#pragma mark - getter
- (LQSReItemExtParam *)extParams {
    if (!_extParams) {
        _extParams = [[LQSReItemExtParam alloc] init];
    }
    
    return _extParams;
}

@end
