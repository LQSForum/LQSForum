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
    _userImage.contentMode = UIViewContentModeCenter;
    _userImage.clipsToBounds = YES;
//    _userImage.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_userImage];
//    用户名
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _userNameLabel.font = [UIFont systemFontOfSize:12];
//    _userNameLabel.backgroundColor = [UIColor magentaColor];
    [self.contentView addSubview:_userNameLabel];

    //    积分
    _jifenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _jifenLabel.font = [UIFont systemFontOfSize:11];
//    _jifenLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_jifenLabel];
    //    香华
    _xianghuaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _xianghuaLabel.font = [UIFont systemFontOfSize:11];

//    _xianghuaLabel.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:_xianghuaLabel];
    //    用户描述
    _userDescription = [[UILabel alloc] initWithFrame:CGRectZero];
    _userDescription.font = [UIFont systemFontOfSize:12];

//    _userDescription.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_userDescription];



}

- (void)pushSettingTopDataModel:(LQSSettingTopDataModel *)model{
    self.model = model;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];

    _userNameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    _jifenLabel.text =[NSString stringWithFormat:@"积分:%@", model.score];
    _xianghuaLabel.text = [NSString stringWithFormat:@"香华:%@", model.credits];
    _userDescription.text = [NSString stringWithFormat:@"%@", model.userTitle];
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat picW = 60;
    CGFloat picH = picW;
    _userImage.frame = CGRectMake(LQSMargin, LQSMargin, picW, picH);
    
    
    _userNameLabel.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin, LQSScreenW - 2 *LQSMargin - picW, picW/3);
    _jifenLabel.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin + picW /3, 50, picW/3);
    _xianghuaLabel.frame = CGRectMake(LQSMargin * 2 + picW + 50, LQSMargin + picW /3, 50, picW/3);
    _userDescription.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin + picW /3 * 2, kScreenWidth - (LQSMargin * 2 + picW + 100), picW/3);


}
@end
