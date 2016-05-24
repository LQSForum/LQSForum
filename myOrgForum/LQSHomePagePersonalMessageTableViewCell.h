//
//  LQSHomePageTableViewCell.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSHomePagePersonalMessageDataModel.h"
@interface LQSHomePagePersonalMessageTableViewCell : LQSRootTableViewCell

- (void)pushesHomePagePersonalMessageWithModel:(LQSHomePagePersonalMessageDataModel *)model;
@end
