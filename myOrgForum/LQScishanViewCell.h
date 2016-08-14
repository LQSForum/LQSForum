//
//  LQScishanViewCell.h
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LQSCishanModelFrame;
@interface LQScishanViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) LQSCishanModelFrame *statusFrame;

@end
