//
//  LQSDiscoverCell.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/7/18.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSWaterFlowViewCell.h"
@class LQSWaterFlowView,LQSShijieDataListModel;

@interface LQSDiscoverCell : LQSWaterFlowViewCell
+ (instancetype)cellWithWaterflowView:(LQSWaterFlowView *)waterflowView;

@property (nonatomic, strong) LQSShijieDataListModel *shijieDataModel;


- (CGFloat)cellHeight;


@end
