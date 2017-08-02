//
//  LQSForumAttentionViewCell.h
//  myOrgForum
//
//  Created by 昱含 on 2017/5/11.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSForumAttentionModel.h"


@class LQSForumAttentionViewCell;
@protocol LQSForumAttentionViewCellDelegate <NSObject>

//跳转到论坛版块详情
- (void)pushToForumDetail:(LQSForumAttentionViewCell *)cell;
//跳转到作者页面
- (void)pushToAuthorPage;

@end
@interface LQSForumAttentionViewCell : UITableViewCell

@property (nonatomic, strong) LQSForumAttentionModel *model;

@property (nonatomic, assign) NSInteger indexpathRow;

- (CGFloat)calculateCellHeightWithData:(LQSForumAttentionModel *)model;

@property (nonatomic, weak) id<LQSForumAttentionViewCellDelegate> delegate;
@end
