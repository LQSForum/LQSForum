//
//  LQSSettingTopCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSettingTopCell.h"
#import "LQSUserManager.h"
@interface LQSSettingTopCell()
{
    UIImageView *_userImage;
    UILabel *_userNameLabel;
    UILabel *_jifenLabel;
    UILabel *_xianghuaLabel;
    UILabel *_userDescription;
    UILabel *_noLoginLabel;



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
    [_userImage.layer setCornerRadius:4.0f];
    [_userImage.layer setMasksToBounds:YES];
    //    _userImage.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_userImage];

    
    
        //    用户名
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _userNameLabel.font = [UIFont systemFontOfSize:14];
        //    _userNameLabel.backgroundColor = [UIColor magentaColor];
        [self.contentView addSubview:_userNameLabel];
        
        //    积分
        _jifenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _jifenLabel.font = [UIFont systemFontOfSize:11];
    [_jifenLabel setTextColor:[UIColor lightGrayColor]];
        //    _jifenLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_jifenLabel];
        //    香华
        _xianghuaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _xianghuaLabel.font = [UIFont systemFontOfSize:11];
    [_xianghuaLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_xianghuaLabel];
        //    用户描述
        _userDescription = [[UILabel alloc] initWithFrame:CGRectZero];
        _userDescription.font = [UIFont systemFontOfSize:12];
    [_userDescription setTextColor:[UIColor orangeColor]];
        //    _userDescription.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_userDescription];

   
}

- (void)pushSettingTopDataModel:(LQSSettingTopDataModel *)model{//???????????????????此处没有使用接口返回的数据用了本地存储的用户信息忘后来师兄修改
    self.model = model;
        [_userImage sd_setImageWithURL:[NSURL URLWithString:[LQSUserManager user].avatar] placeholderImage:nil];
        _noLoginLabel = nil;
        _userNameLabel.text = [LQSUserManager user].userName;
        _jifenLabel.text =[NSString stringWithFormat:@"积分:%@", [LQSUserManager user].score];
        _xianghuaLabel.text = [NSString stringWithFormat:@"香华:%@", [LQSUserManager user].score];
        _userDescription.text = [LQSUserManager user].userTitle;
  
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
