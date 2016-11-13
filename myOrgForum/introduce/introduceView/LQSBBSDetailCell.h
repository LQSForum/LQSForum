//
//  LQSBBSDetailCell.h
//  myOrgForum
//  功能：帖子详情页cell
//  Created by XJW on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSBBSDetailViewController.h"

@protocol LQSBBSDetailCellDelegate <NSObject>
// 暂时不定义方法.只用这个delegate来拿到cell所在的vc.
// 通过代理来完成跳转事件或其他事件,而不是在cell这里控制控制器的跳转.
- (void)pushToReport;
@end
@interface LQSBBSDetailCell : UITableViewCell

//@property (nonatomic, strong) NSMutableDictionary *paramDict;//参数字典
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) LQSBBSDetailViewController *myCtrl;
@property (nonatomic,assign)id <LQSBBSDetailCellDelegate> bbsDetailDelegate;

@end
