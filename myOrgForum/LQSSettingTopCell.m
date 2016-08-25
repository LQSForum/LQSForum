//
//  LQSSettingTopCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSettingTopCell.h"

@interface LQSSettingTopCell()
{
    UIImageView *_userImage;
    UILabel *_userNameLabel;
    UILabel *_jifenLabel;
    UILabel *_xianghuaLabel;
    UILabel *_userDescription;




}
@property (nonatomic, strong) LQSSettingTopDataModel *model;

@end
@implementation LQSSettingTopCell

- (void)loadSubViews
{
    [super loadSubViews];
//用户头像
    _userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_userImage];
//    用户名
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_userNameLabel];

    //    积分
    _jifenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_jifenLabel];
    //    香华
    _xianghuaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_xianghuaLabel];
    //    用户描述
    _userDescription = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_userDescription];



}


- (void)pushSettingTopDataModel:(LQSSettingTopDataModel *)model{
    self.model = model;
    _userImage.image = [UIImage imageNamed:model.icon];

    _userNameLabel.text = model.name;
    _jifenLabel.text = model.score;
    _xianghuaLabel.text = model.credits;
    _userDescription.text = model.userTitle;
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat picW = 70;
    CGFloat picH = picW;
    _userImage.frame = CGRectMake(LQSMargin, LQSMargin, picW, picH);
    
    
    _userNameLabel.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin, LQSScreenW - 2 *LQSMargin - picW, picW/3);
    _jifenLabel.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin + picW /3, 80, picW/3);
    _xianghuaLabel.frame = CGRectMake(LQSMargin * 2 + picW + 80, LQSMargin + picW /3 * 2, 80, picW/3);
    _userDescription.frame = CGRectMake(LQSMargin * 2 + picW + 80, LQSMargin + picW /3 * 3, kScreenWidth - (LQSMargin * 2 + picW + 100), picW/3);


}
@end
