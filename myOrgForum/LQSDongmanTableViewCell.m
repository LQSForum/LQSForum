
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
    UILabel *_timeLabel;
    UILabel *_sourceLabel;
    UILabel *_contentLabel;
    UIImageView *_picsView;
    UILabel *_fangwenLabel;
    UILabel *_pinglunLabel;
    NSArray *_picViewArr;
    UIImageView *_userView;
    UIImageView *_photoView;
    NSMutableArray *_tempArr;
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
    _userAvaterView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_userAvaterView];
    
//    用户名称
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _userAvaterView.backgroundColor = [UIColor yellowColor];

    _userNameLabel.font = [UIFont systemFontOfSize:15];
    _userNameLabel.backgroundColor = [UIColor blueColor];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_userNameLabel];
//  timeLabel时间label
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_timeLabel];
    
//    帖子来源
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _userAvaterView.backgroundColor = [UIColor greenColor];

    _sourceLabel.font = [UIFont systemFontOfSize:12];
    _sourceLabel.backgroundColor = [UIColor cyanColor];

    [self.contentView addSubview:_sourceLabel];
//    帖子内容
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel.backgroundColor = [UIColor purpleColor];

    _contentLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_contentLabel];

//   帖子图片
    
//    访问量
    _fangwenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _fangwenLabel.backgroundColor = [UIColor magentaColor];
    _fangwenLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_fangwenLabel];

//    评论数
    _pinglunLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _pinglunLabel.backgroundColor = [UIColor lightGrayColor];
    _pinglunLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_pinglunLabel];





}

- (void)pushesDongmanDataModel:(LQSDongmanListModel *)model
{
    _dongmanData = model;
    NSURL *avaterURL = [NSURL URLWithString:model.userAvatar];//红
    [_userAvaterView sd_setImageWithURL:avaterURL placeholderImage:nil ];//红
    _userNameLabel.text = model.user_nick_name;//blue
    _timeLabel.text = model.last_reply_date;
    _sourceLabel.text = model.board_name;//cyan
    _contentLabel.text = model.title;//purple
    _fangwenLabel.text = model.hits;//magentale
    _pinglunLabel.text = model.replies;//lightGray
//    获取图片群
    _picViewArr = [model.imageList componentsSeparatedByString:@","];
    [_picViewArr arrayByAddingObject:model.pic_path];
    NSUInteger count = _tempArr.count;
    for (NSUInteger i = 0; i < count; i++) {
        _photoView = [[UIImageView alloc] init];
        _photoView.tag = i;
        [_imageViews addObject:_photoView];
    }
    for (NSUInteger idx = 0; idx < count; idx++) {
        UIView *view = [_imageViews objectAtIndex:idx];
        [self.contentView addSubview:view];
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
        mjphoto.url = [NSURL URLWithString:[_tempArr objectAtIndex:i]];
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
    CGFloat margin = 10;
    CGFloat picW = (kScreenWidth - 4 * margin)/3;
    //计算图片的frame
    //    计算有多少行
    NSUInteger rows = _tempArr.count /3;
    //    计算有多少咧
    NSUInteger cols = _tempArr.count % 3;
    
    for (NSUInteger i = 0; i < _tempArr.count; i++) {
        _userView.frame = CGRectMake(margin + (margin + picW) * cols, margin + (margin + picW) * rows , picW, picW);
    }
    
//    添加点击量
    _fangwenLabel.frame = CGRectMake(kScreenWidth - 100, self.height - 20, 50, 20);
//    添加评论数
    _pinglunLabel.frame = CGRectMake(kScreenWidth - 50, self.height - 20, 50, 20);
    
    
    
    
    
    
    
    CGFloat touxiangPicW = 30;
//用户头像
    _userAvaterView.frame = CGRectMake(10, 10, touxiangPicW, touxiangPicW);
//    用户名称
    _userNameLabel.frame = CGRectMake(10 + touxiangPicW + 10, 10,( kScreenWidth - 2 * 10 - touxiangPicW)* 0.5, touxiangPicW * 0.5);
    _timeLabel.frame = CGRectMake(10 + touxiangPicW + 10, 10 + touxiangPicW * 0.5,( kScreenWidth - 2 * 10 - touxiangPicW)* 0.5 , touxiangPicW * 0.5);
    _timeLabel.backgroundColor = [UIColor redColor];
//    来源
    _sourceLabel.frame = CGRectMake(CGRectGetMaxX(_userNameLabel.frame), 10, ( kScreenWidth - 2 * 10 - touxiangPicW)* 0.5, touxiangPicW * 0.5);
    _sourceLabel.textAlignment = NSTextAlignmentRight;
//    文字内容
    CGSize size = [self sizeWithText:_dongmanData.summary font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    _contentLabel.frame = CGRectMake(10, 10+touxiangPicW+10, kScreenWidth, size.height);
    
    
    
    
    
    
    
    
    
}

@end
