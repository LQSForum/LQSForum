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
// 跳转打赏页面
- (void)pushToDashang;
- (void)pushToReply;
@end
@interface LQSBBSDetailCell : UITableViewCell
@property (nonatomic,assign)id <LQSBBSDetailCellDelegate> delegate;

- (void)setCellWithData:(id)modelData indexpath:(NSIndexPath *)indexpath;

@end
// 标题cell
@interface LQSBBSDetailTitleCell : LQSBBSDetailCell

@property (nonatomic,strong)LQSBBSDetailTopicModel *topicModel;

@end
// 内容cell
@interface LQSBBSDetailContentCell : LQSBBSDetailCell
@property (nonatomic,strong)LQSBBSDetailTopicModel *topicModel;

@end
// 打赏cell
@interface LQSBBSDetailVoteCell : LQSBBSDetailCell

@property (nonatomic,strong)LQSBBSDetailTopicModel *topicModel;
@end
// 评论回复cell
@interface LQSBBSDetailReplyCell : LQSBBSDetailCell
@property (nonatomic,strong)LQSBBSPosterModel *pinglunModel;

@end







