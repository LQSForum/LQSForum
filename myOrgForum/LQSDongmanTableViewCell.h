//
//  LQSDongmanTableViewCell.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/16.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LQSDongmanListModel;
@interface LQSDongmanTableViewCell : LQSRootTableViewCell

- (void)pushesDongmanDataModel:(LQSDongmanListModel *)model;
@end
