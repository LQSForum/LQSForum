
//
//  LQSSettingCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSettingCell.h"
#import "UIView+Extension.h"
@interface LQSSettingCell()
{

    UIImageView *_imageView;
    UILabel *_titleLabel;

}
@property (nonatomic, strong) LQSSettingModel *model;

@end

@implementation LQSSettingCell

- (void)loadSubViews
{
//创建头像
   _imageView  = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageView];
//    创建对应的名称
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_titleLabel];

}

- (void)pushSettingModel:(LQSSettingModel *)model
{
    self.model = model;
    _imageView.image = [UIImage imageNamed:model.iamge];
    _titleLabel.text = model.title;
    [self layoutIfNeeded];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(LQSMargin, 0, 30, self.height);
    _imageView.contentMode = UIViewContentModeCenter;
    
    _titleLabel.frame = CGRectMake(LQSMargin * 2 + 30, 0, self.width - 50 - LQSMargin * 2 - 10, self.height);
    _titleLabel.textAlignment = NSTextAlignmentLeft;



}

@end
