//
//  LQSForumDetailChildCell.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailChildCell.h"
@interface LQSForumDetailChildCell()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastPostsDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *tdPostsNumLbl;
@end
@implementation LQSForumDetailChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)setModel:(LQSCellModel *)model{
    _nameLabel.text = model.board_name;
    _timeLabel.text = [NSString stringWithFormat:@"最近更新:%@",@""];
    _lastPostsDateLbl.text = [NSString stringWithFormat:@"%@",model.last_posts_date];
    _tdPostsNumLbl.text =  [NSString stringWithFormat:@"(%zd)",model.td_posts_num];
}

@end
