//
//  LQSCishanTableViewCell.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/18.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSRootTableViewCell.h"
@class LQSCishanListModel;
@interface LQSCishanTableViewCell : LQSRootTableViewCell
- (void)pushesCishanDataModel:(LQSCishanListModel *)model;

//cell高度
- (CGFloat)cellHeight;

@end
