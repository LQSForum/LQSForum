//
//  LQSBBSDetailViewController.h
//  myOrgForum
//  功能 ： 论坛详情页
//  Created by 徐经纬 on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSIntroduceMainListModel.h"
#import "LQSBBSDetailModel.h"

@interface LQSBBSDetailViewController : UIViewController

@property (nonatomic, strong) LQSBBSDetailModel *bbsDetailModel;
// topicModel
@property (nonatomic, strong) LQSBBSDetailTopicModel *bbsDetailTopicModel;
// replayModel
@property (nonatomic, strong) LQSBBSPosterModel *bbsDetailPosterModel;
@property (nonatomic, strong) LQSIntroduceMainListModel *selectModel;// 暂时不用。
// 用于跳转帖子
@property (nonatomic,strong)NSString *boardID;
@property (nonatomic,strong)NSString *topicID;
@end
