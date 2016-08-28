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
}

@end
