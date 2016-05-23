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
    UILabel *_label;

}
@property (nonatomic, strong) LQSSettingPersonalSettingDataModel *model;

@end

@implementation LQSSettingPersonalSettingViewCell


- (void)loadSubViews
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_label];



}



- (void)pushesSettingPersonalSettingModel:(LQSSettingPersonalSettingDataModel *)model
{
    _model = model;
    
    _imageView.image = [UIImage imageNamed:model.imageName];
    _label.text = model.title;



    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _imageView.frame = CGRectMake(LQSMargin, 0, 50, self.height);
    _imageView.contentMode = UIViewContentModeCenter;
    
    _label.frame = CGRectMake(LQSMargin *2 + 50, 0, self.width - LQSMargin *2 - 50, self.height);
    _label.textAlignment =  NSTextAlignmentLeft;

}
@end
