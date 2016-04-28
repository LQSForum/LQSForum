
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
    _imageView.frame = CGRectMake(10, 7, 30, 30);
    _imageView.contentMode = UIViewContentModeCenter;
    
    _titleLabel.frame = CGRectMake(50, 0, self.width - 100, 44);
    _titleLabel.textAlignment = NSTextAlignmentLeft;



}

@end
