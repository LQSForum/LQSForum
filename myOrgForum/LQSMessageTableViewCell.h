//
//  LQSMessageTableViewCell.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSMessageDataModel.h"
@interface LQSMessageTableViewCell : LQSRootTableViewCell

- (void)PushesmessageTableViewModel:(LQSMessageDataModel *)model;
@end
