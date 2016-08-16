
//
//  LQSDongmanTableViewCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/16.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSDongmanTableViewCell.h"

@interface LQSDongmanTableViewCell()
{
    UIImageView *_userAvaterView;
    UILabel *_userNameLabel;
    UILabel *_sourceLabel;
    UILabel *_contentLabel;
    UIImageView *_picsView;
    UILabel *_fangwenLabel;
    UILabel *_pinglunLabel;
    NSArray *_picViewArr;
    NSMutableArray *_imageViews;
    LQSDongmanListModel *_dongmanData;

}
@end

@implementation LQSDongmanTableViewCell

- (void)loadSubViews
{
    _picViewArr = [NSMutableArray array];
//用户头像
    _userAvaterView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_userAvaterView];
    
//    用户名称
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _userNameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_userNameLabel];

    
//    帖子来源
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_sourceLabel];
//    帖子内容
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_contentLabel];

//   帖子图片
    
//    访问量
    _fangwenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _fangwenLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_fangwenLabel];

//    评论数
    _pinglunLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _pinglunLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_pinglunLabel];





}

- (void)pushesDongmanDataModel:(LQSDongmanListModel *)model
{
    _dongmanData = model;
    NSURL *avaterURL = [NSURL URLWithString:model.pic_path];
    [_userAvaterView sd_setImageWithURL:avaterURL placeholderImage:nil ];
    [_userNameLabel.text isEqualToString:model.user_nick_name];
    [_sourceLabel.text isEqualToString:model.board_name];
    [_contentLabel.text isEqualToString:model.summary];
    [_fangwenLabel.text isEqualToString:model.hits];
    [_pinglunLabel.text isEqualToString:model.recommendAdd];
//    获取图片群
    _picViewArr = [model.imageList componentsSeparatedByString:@","];
    NSUInteger count = _picViewArr.count;
    for (NSUInteger i = 0; i < count; i++) {
        LQSPhotoView *photoView = [[LQSPhotoView alloc] init];
        photoView.tag = i;
        [_imageViews addObject:photoView];
        // 2.添加点击事件
        [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
    }
    for (NSUInteger idx = 0; idx < count; idx++) {
        UIView *userView = [_imageViews objectAtIndex:idx];
        [self.contentView addSubview:userView];
    }
    [self setNeedsLayout];

}

/**
 *  点击了某个图片
 */
- (void)photoTap:(UITapGestureRecognizer *)tap
{
    // 1.创建浏览器对象
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置浏览器对象的所有图片
    NSMutableArray *mjphotos = [NSMutableArray array];
    for (int i = 0; i<_picViewArr.count; i++) {
        // 创建MJPhoto模型
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        // 设置图片的url
        mjphoto.url = [NSURL URLWithString:[_picViewArr objectAtIndex:i]];
        // 设置图片的来源view
        mjphoto.srcImageView = self.subviews[i];
        [mjphotos addObject:mjphoto];
    }
    browser.photos = mjphotos;
    // 3.设置浏览器默认显示的图片位置
    browser.currentPhotoIndex = tap.view.tag;
    // 4.显示浏览器
    [browser show];
}

- (CGSize)sizeWithText:(NSString *)text
                  font:(UIFont *)font
               maxSize:(CGSize)masxSize{

    return [text boundingRectWithSize:masxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;


}



- (void)layoutSubviews
{

    [super layoutSubviews];

//用户头像
    _userAvaterView.frame = CGRectMake(10, 10, 50, 50);
//    用户名称
    _userNameLabel.frame = CGRectMake(10 + 50 + 10, 10, kScreenWidth * 0.5, 25);
    _userNameLabel.textAlignment = NSTextAlignmentRight;
//    来源
    _sourceLabel.frame = CGRectMake(kScreenWidth * 0.5, 10, kScreenWidth * 0.5, 25);
    _sourceLabel.textAlignment = NSTextAlignmentRight;
//    文字内容
    CGSize size = [self sizeWithText:_dongmanData.summary font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    _contentLabel.frame = CGRectMake(10, 10+50+10, kScreenWidth, size.height);



}

@end
