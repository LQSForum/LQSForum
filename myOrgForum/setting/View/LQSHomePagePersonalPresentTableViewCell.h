//
//  LQSDongmanTableViewCell.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/16.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LQSHomePagePersonalPresentDataModel;


@interface  LQSHomePagePersonalPresentTableViewCell: LQSRootTableViewCell



- (void)pushesDongmanDataModel:(LQSHomePagePersonalPresentDataModel *)model;

//cell高度
- (CGFloat)cellHeight;
@end
