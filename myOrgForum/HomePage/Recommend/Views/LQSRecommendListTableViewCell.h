//
//  LQSRecommendListTableViewCell.h
//  myOrgForum
//
//  Created by wangbo on 2017/6/14.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSRecommendListModel.h"

@interface LQSRecommendListTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) LQSRecommendListModel *recommendModel;

- (void)updateCellWithModel:(LQSRecommendListModel *)recommendModel;

+ (CGFloat)heightWithRecommendListModel:(LQSRecommendListModel *)recommendModel;

@end
