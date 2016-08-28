//
//  LQSBBSDetailCell.h
//  myOrgForum
//  功能：帖子详情页cell
//  Created by XJW on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSBBSDetailCell : UITableViewCell

@property (nonatomic, strong) NSMutableDictionary *paramDict;//参数字典
@property (nonatomic, weak) UIViewController *myCtrl;

@end
