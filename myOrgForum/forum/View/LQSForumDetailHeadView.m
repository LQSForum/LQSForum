//
//  LQSForumDetailHeadView.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailHeadView.h"
@interface LQSForumDetailHeadView()
@property (nonatomic, readwrite, retain) IBOutlet UIImageView *mainImageView;
@property (nonatomic, readwrite, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, readwrite, retain) IBOutlet UILabel *introLabel;
@property (nonatomic, readwrite, retain) IBOutlet UILabel *subTitleLabel;
@property (nonatomic, readwrite, retain) IBOutlet UILabel *todayNumLabel;
@property (nonatomic, readwrite, retain) IBOutlet UIButton *followButton;
@end
@implementation LQSForumDetailHeadView

- (void)setModel:(LQSForumDetailForumInfoModel *)model{
    _titleLabel.text = model.title;
    _introLabel.text = model.desc;
    _subTitleLabel.text = [NSString stringWithFormat:@"主题:%zd",model.postsTotalNum];
    _todayNumLabel.text = [NSString stringWithFormat:@"今日:%zd",model.tdPostsNum];
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
}

@end
