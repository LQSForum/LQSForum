//
//  LQSDiscoverCell.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/7/18.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSWaterFlowViewCell.h"
@class LQSWaterFlowView,LQSDiscover;

@interface LQSDiscoverCell : LQSWaterFlowViewCell
+ (instancetype)cellWithWaterflowView:(LQSWaterFlowView *)waterflowView;

@property (nonatomic, strong) LQSDiscover *discover;

@end
