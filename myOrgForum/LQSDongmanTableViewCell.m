
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
    NSMutableArray *_picViewArr;
    NSArray *_tempPicArr;
    UIImageView *_userView;
    UIImageView *_photoView;
    NSMutableArray *_imageViews;
    LQSDongmanListModel *_dongmanData;
    CGFloat _picW;
    CGFloat _touxiangPicW;
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
    _contentLabel.numberOfLines = 0;
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
    if (_picViewArr) {
        [_picViewArr removeAllObjects];
    }{
//        _tempPicArr = [NSArray array];
//        _tempPicArr = [model.imageList componentsSeparatedByString:@","];
//        for (NSUInteger j; j < _tempPicArr.count; j++) {
//            NSObject *obj = [_tempPicArr objectAtIndex:j];
//            [_picViewArr addObject:obj];
//        }
//        [_picViewArr addObjectsFromArray:_tempPicArr];
        
        
//    [_picViewArr addObject:model.pic_path];
        
        [_picViewArr addObjectsFromArray:model.imageList];
        
        
        
    }
    NSUInteger count = _picViewArr.count;
    if (count != 0) {
        if (_imageViews) {
            for (UIView *subView in _imageViews) {
                [subView removeFromSuperview];
            }
        }
    }
    
    _imageViews = [NSMutableArray array];

    for (NSUInteger i = 0; i < count; i++) {
        _photoView = [[UIImageView alloc] init];
        NSURL *url = [NSURL URLWithString:[_picViewArr objectAtIndex:i]];
        [_photoView sd_setImageWithURL:url placeholderImage:nil];
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
    
    
    
    
     _touxiangPicW = 30;
    //用户头像
    _userAvaterView.frame = CGRectMake(10, 10, _touxiangPicW, _touxiangPicW);
    //    用户名称
    _userNameLabel.frame = CGRectMake(10 + _touxiangPicW + 10, 10,( kScreenWidth - 2 * 10 - _touxiangPicW)* 0.5, _touxiangPicW * 0.5);
    _timeLabel.frame = CGRectMake(10 + _touxiangPicW + 10, 10 + _touxiangPicW * 0.5,( kScreenWidth - 2 * 10 - _touxiangPicW)* 0.5 , _touxiangPicW * 0.5);
    _timeLabel.backgroundColor = [UIColor redColor];
    //    来源
    _sourceLabel.frame = CGRectMake(CGRectGetMaxX(_userNameLabel.frame), 10, ( kScreenWidth - 2 * 10 - _touxiangPicW)* 0.5, _touxiangPicW * 0.5);
    _sourceLabel.textAlignment = NSTextAlignmentRight;
    //    文字内容
    CGSize size = [self sizeWithText:_dongmanData.title font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    _contentLabel.frame = CGRectMake(10, 10+_touxiangPicW+10, kScreenWidth, size.height);
    
    [super layoutSubviews];
    CGFloat LQSMargin = 10;
     _picW = (kScreenWidth - 4 * LQSMargin)/3;
    //计算图片的frame
    for (NSUInteger i = 0; i < _picViewArr.count; i++) {
        //    计算有多少行
        NSUInteger rows = i /3;
        //    计算有多少咧
        NSUInteger cols = i % 3;
        

        UIView *userView = [_imageViews objectAtIndex:i];
        userView.backgroundColor = [UIColor blueColor];
        userView.tag = i;
        userView.width = _picW;
        userView.height = _picW;
        userView.frame = CGRectMake(cols * (LQSMargin + _picW) + LQSMargin, rows * (LQSMargin + _picW) + LQSMargin + CGRectGetMaxY(_contentLabel.frame), _picW, _picW);
    }
    
    
    CGFloat tooY;
    if (_picViewArr.count <= 3) {
        tooY = CGRectGetMaxY(_contentLabel.frame) + 2 * LQSMargin + _picW;
    }else if (_picViewArr.count > 3 && _picViewArr.count <= 6){
        tooY = CGRectGetMaxY(_contentLabel.frame) + 3 * LQSMargin + _picW * 2;
    
    }else if (_picViewArr.count > 6 && _picViewArr.count <= 9){
        tooY = CGRectGetMaxY(_contentLabel.frame) + 4 * LQSMargin + _picW * 3;
        
    }
    
    
    
    
    
    
    //    添加点击量
    _fangwenLabel.frame = CGRectMake(kScreenWidth - 100, tooY, 50, 20);
    //    添加评论数
    _pinglunLabel.frame = CGRectMake(kScreenWidth - 50, tooY, 50, 20);
    

}

- (CGFloat)cellHeight{
    CGFloat cellHeight;
    _touxiangPicW = 30;
    _picW = (kScreenWidth - 4 * LQSMargin)/3;
    CGSize size = [self sizeWithText:_dongmanData.title font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    if (_picViewArr.count <= 0) {
        cellHeight = _touxiangPicW + size.height  + 2 * LQSMargin + LQSMargin + 20;
    }else if (_picViewArr.count <= 3) {
        cellHeight = _touxiangPicW + size.height + 3 * LQSMargin + _picW+ LQSMargin+ 20;
    }else if (_picViewArr.count <= 6){
        cellHeight = _touxiangPicW + size.height + 4 * LQSMargin + _picW * 2+ LQSMargin+ 20;
    }else{
        cellHeight = _touxiangPicW + size.height + 5 * LQSMargin + _picW * 3+ LQSMargin+ 20;

    }
    return cellHeight;

}

@end
