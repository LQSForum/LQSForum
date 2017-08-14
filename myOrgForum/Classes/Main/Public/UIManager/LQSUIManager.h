//
//  LQSUIManager.h
//  myOrgForum
//
//  Created by wangbo on 2017/6/25.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQSRecommendItemModel.h"

@protocol LQSUIManagerDelegate <NSObject>

- (void)LoadDataSuccess;
- (void)requestDataFailure;

@end

@interface LQSUIManager : NSObject

@property (nonatomic, strong) NSMutableArray<LQSRecommendItemModel> *rotationImageArray;
@property (nonatomic, strong) NSMutableArray<LQSRecommendItemModel> *recommendButtonArray;

+ (LQSUIManager *)sharedManager;

@end
