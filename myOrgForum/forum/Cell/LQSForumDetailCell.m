//
//  LQSForumDetailCell.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailCell.h"
@interface LQSForumDetailCell()
@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@end
@implementation LQSForumDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)setModel:(LQSForumDetailListModel *)model{
    if (model.picPath.length > 0) {
        _mainImageView.hidden = NO;
        [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.picPath]];
    }
    else{
        _mainImageView.hidden = YES;
    }
    _titleLabel.text = model.title;
    _nameLabel.text = model.userNickName;
    _numLabel.text = [NSString stringWithFormat:@"%zd评",model.replies];
    _timeLabel.text = [model last_posts_date];
}

@end
