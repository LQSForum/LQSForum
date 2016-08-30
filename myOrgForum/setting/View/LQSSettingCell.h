//
//  LQSSettingCell.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSRootTableViewCell.h"
#import "LQSSettingModel.h"
@interface LQSSettingCell : LQSRootTableViewCell

- (void)pushSettingModel:(LQSSettingModel *)model;
@end
