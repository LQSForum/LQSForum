//
//  LQSReRotationImageModel.m
//  myOrgForum
//
//  Created by wangbo on 2017/7/16.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSReRotationImageModel.h"

@implementation LQSReRotationImageModel

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

#pragma mark - getter

- (LQSReImageExtParam *)extParams {
    if (!_extParams) {
        _extParams = [[LQSReImageExtParam alloc] init];
    }
    
    return _extParams;
}

@end
