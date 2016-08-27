//
//  LQSForumDetailTopCell.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailTopCell.h"
@interface LQSForumDetailTopCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation LQSForumDetailTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)setModel:(LQSForumDetailTopModel *)model{
    _titleLabel.text = model.title;
}

@end
