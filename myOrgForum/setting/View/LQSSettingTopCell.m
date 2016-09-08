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
    //    _userImage.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_userImage];

    
    
    if ([LQSUserManager isLoging]) {
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

    }else{
    
        _noLoginLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _noLoginLabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_noLoginLabel];
    
    }
    
    
    



}

- (void)pushSettingTopDataModel:(LQSSettingTopDataModel *)model{
    self.model = model;
    
    
    
    if ([LQSUserManager isLoging]) {
        [_userImage sd_setImageWithURL:[NSURL URLWithString:[LQSUserManager user].avatar] placeholderImage:nil];
        
        _userNameLabel.text = [LQSUserManager user].userName;
        _jifenLabel.text =[NSString stringWithFormat:@"积分:%@", [LQSUserManager user].score];
        _xianghuaLabel.text = [NSString stringWithFormat:@"香华:%@", [LQSUserManager user].score];
        _userDescription.text = [LQSUserManager user].userTitle;
    }else{
        [_userImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"setting_profile_bgWall.jpg"]];
 
    _noLoginLabel.text = @"请点击登录/注册";
    }
    
    
    
    
    
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat picW = 60;
    CGFloat picH = picW;
    _userImage.frame = CGRectMake(LQSMargin, LQSMargin, picW, picH);
    
    if ([LQSUserManager isLoging]) {
        _userNameLabel.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin, LQSScreenW - 2 *LQSMargin - picW, picW/3);
        _jifenLabel.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin + picW /3, 50, picW/3);
        _xianghuaLabel.frame = CGRectMake(LQSMargin * 2 + picW + 50, LQSMargin + picW /3, 50, picW/3);
        _userDescription.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin + picW /3 * 2, kScreenWidth - (LQSMargin * 2 + picW + 100), picW/3);
    }else{
        _noLoginLabel.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin, kScreenWidth - (LQSMargin * 2 + picW + 100), picH);
        _noLoginLabel.textAlignment = NSTextAlignmentCenter;
        _noLoginLabel.font = [UIFont systemFontOfSize:15];
    
    
    }
    
    
    


}
@end
