//
//  LQSForumDetailTopCell.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailTopCell.h"
#import "UIColor+Hex.h"

@interface LQSForumDetailTopCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *topLabel;
@end
@implementation LQSForumDetailTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    _topLabel.backgroundColor = [UIColor lqs_themeColor];
}

- (void)setModel:(LQSForumDetailTopModel *)model{
    _titleLabel.text = model.title;
}

@end
