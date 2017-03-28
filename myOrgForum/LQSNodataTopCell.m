//
//  LQSNodataTopCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/9/9.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSNodataTopCell.h"

@interface LQSNodataTopCell()

{
    UIImageView *_userImage;
    
    UILabel *_noLoginLabel;
    
    
}

@property (nonatomic, strong) LQSSettingTopDataModel *model;


@end

@implementation LQSNodataTopCell

- (void)loadSubViews
{
    _userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userImage.contentMode = UIViewContentModeCenter;
    _userImage.clipsToBounds = YES;
    //    _userImage.backgroundColor = [UIColor cyanColor];
    [_userImage.layer setCornerRadius:4.0f];
    [_userImage.layer setMasksToBounds:YES];
    [self.contentView addSubview:_userImage];
    
    _noLoginLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_noLoginLabel];
}

- (void)pushSettingTopNoDataDataModel:(LQSSettingTopDataModel *)model{
    self.model = model;
    [_userImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"setting_profile_bgWall.jpg"]];
    _noLoginLabel.text = @"请点击登录/注册";
    [self layoutIfNeeded];
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat picW = 60;
    CGFloat picH = picW;
    _userImage.frame = CGRectMake(LQSMargin, LQSMargin, picW, picH);
    _noLoginLabel.frame = CGRectMake(LQSMargin * 2 + picW, LQSMargin, kScreenWidth - (LQSMargin * 2 + picW + 100), picH);
    _noLoginLabel.textAlignment = NSTextAlignmentCenter;
    _noLoginLabel.font = [UIFont systemFontOfSize:15];
    
    
}








@end
