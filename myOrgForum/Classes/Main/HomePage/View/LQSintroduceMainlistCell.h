//
//  LQSintroduceMainlistCell.h
//  myOrgForum
//
//  Created by XJW on 16/8/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSIntroduceMainListModel.h"

@interface LQSintroduceMainlistCell : UITableViewCell

@property (nonatomic, strong) NSMutableDictionary *paramDict;//参数字典
@property (nonatomic, weak) UIViewController *myCtrl;

//- (void)setCellForIndexPath:(NSIndexPath *)indexPath;

@end
