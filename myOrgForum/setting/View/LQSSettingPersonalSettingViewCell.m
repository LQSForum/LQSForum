//
//  LQSSettingPersonalSettingViewCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/23.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSettingPersonalSettingViewCell.h"

@interface LQSSettingPersonalSettingViewCell()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;


}
@property (nonatomic, strong) LQSSettingPersonalSettingDataModel *model;

@end

@implementation LQSSettingPersonalSettingViewCell


- (void)loadSubViews
{
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//    [self.contentView addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_titleLabel];

    _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_subTitleLabel];


}



- (void)pushesSettingPersonalSettingModel:(LQSSettingPersonalSettingDataModel *)model
{
    _model = model;
    
    _imageView.image = [UIImage imageNamed:model.imageName];
    _titleLabel.text = model.title;
    _subTitleLabel.text = model.subTitle;


    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

//    _imageView.frame = CGRectMake(LQSMargin, 0, 50, self.height);
//    _imageView.contentMode = UIViewContentModeCenter;
    
    _titleLabel.frame = CGRectMake(LQSMargin, 0, self.width - LQSMargin *2 - 50, self.height);
    _titleLabel.textAlignment =  NSTextAlignmentLeft;

    
    _subTitleLabel.frame = CGRectMake(LQSMargin, self.height - 20, self.width - LQSMargin *2 - 50, 20);
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    _subTitleLabel.textColor = [UIColor lightGrayColor];
    _subTitleLabel.font = [UIFont systemFontOfSize:12];
    _subTitleLabel.textAlignment =  NSTextAlignmentLeft;
}
@end
