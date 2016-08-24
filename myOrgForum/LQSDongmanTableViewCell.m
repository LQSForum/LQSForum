
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
    UILabel *_laiziLabel;
    UILabel *_contentLabel;
    UIImageView *_picsView;
    UILabel *_fangwenLabel;
    UILabel *_pinglunLabel;
    UIImageView *_pinglunPic;
    UIImageView *_fangwenPic;
    
    NSMutableArray *_picViewArr;
    NSArray *_tempPicArr;
    UIImageView *_userView;
    UIImageView *_photoView;
    NSMutableArray *_imageViews;
    LQSDongmanListModel *_dongmanData;
    CGFloat _picW;
    CGFloat _touxiangPicW;
    NSUInteger _picCount;

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
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_userNameLabel];
//  timeLabel时间label
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_timeLabel];
    
    //    帖子来源
    
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    _sourceLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_sourceLabel];

//    来自控件 来自：
    _laiziLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _laiziLabel.textAlignment = NSTextAlignmentLeft;
    _laiziLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_laiziLabel];
//    帖子内容
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel.numberOfLines = 0;

    _contentLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_contentLabel];

//   帖子图片
    
//    访问量
    _fangwenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _fangwenLabel.textAlignment = NSTextAlignmentCenter;
    _fangwenLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_fangwenLabel];

//    评论数
    _pinglunLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _pinglunLabel.textAlignment = NSTextAlignmentCenter;
    _pinglunLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_pinglunLabel];

    _pinglunPic = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_pinglunPic setContentMode:UIViewContentModeCenter];
    [self.contentView addSubview:_pinglunPic];

    _fangwenPic = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_fangwenPic setContentMode:UIViewContentModeCenter];
    [self.contentView addSubview:_fangwenPic];


}

- (void)pushesDongmanDataModel:(LQSDongmanListModel *)model
{
    _dongmanData = model;
    NSURL *avaterURL = [NSURL URLWithString:model.userAvatar];//红
    [_userAvaterView sd_setImageWithURL:avaterURL placeholderImage:nil ];//红
    _userNameLabel.text = model.user_nick_name;//blue
    _timeLabel.text = model.last_reply_date;
    _sourceLabel.text = model.board_name;//cyan
    _laiziLabel.text = @"来自";
    
    CGFloat pinglunCount;
    NSString * pinglunStr;
    pinglunCount = [model.replies floatValue];
    if (pinglunCount > 9999) {
        pinglunCount = pinglunCount / 10000;
        pinglunStr = [NSString stringWithFormat:@"%.f万",pinglunCount];
    }else{
        pinglunStr = [NSString stringWithFormat:@"%.f",pinglunCount];
    }
    CGFloat fangwenCount;

    NSString * fangwenStr;
    fangwenCount = [model.hits floatValue];
    if (fangwenCount > 9999) {
        fangwenCount = pinglunCount / 10000;
        fangwenStr = [NSString stringWithFormat:@"%.f万",fangwenCount];
    }else{
        fangwenStr = [NSString stringWithFormat:@"%.f",fangwenCount];
    }
    
    _contentLabel.text = model.title;//purple
    _fangwenLabel.text = fangwenStr;//magentale
    _pinglunLabel.text = pinglunStr;//lightGray
    _fangwenPic.image = [UIImage imageNamed:@"discover_liulan"];
    _pinglunPic.image = [UIImage imageNamed:@"discover_pinglun"];
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

    if (count <= 3) {
        _picCount = _picViewArr.count;
    }else{
        _picCount = 3;
    }
    
    
    
    for (NSUInteger i = 0; i < _picCount; i++) {
        _photoView = [[UIImageView alloc] init];
        NSURL *url = [NSURL URLWithString:[_picViewArr objectAtIndex:i]];
        [_photoView sd_setImageWithURL:url placeholderImage:nil];
        _photoView.tag = i;
        _photoView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
        [_photoView addGestureRecognizer:tapGesture];
        [_imageViews addObject:_photoView];
    }
    
    for (NSUInteger idx = 0; idx < _picCount; idx++) {
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
    for (int i = 0; i<_picCount; i++) {
        // 创建MJPhoto模型
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        // 设置图片的url
        mjphoto.url = [NSURL URLWithString:[_picViewArr objectAtIndex:i]];
        // 设置图片的来源view
        mjphoto.srcImageView = _imageViews[i];
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
    

    //    来源
    CGSize laiyuanSize = [self sizeWithText:_dongmanData.board_name font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    _sourceLabel.frame = CGRectMake(LQSScreenW - laiyuanSize.width, 10, laiyuanSize.width, _touxiangPicW * 0.5);
    _sourceLabel.textAlignment = NSTextAlignmentRight;
    
    _laiziLabel.frame = CGRectMake(CGRectGetMinX(_sourceLabel.frame) - 30, 10, 30, _touxiangPicW * 0.5);

    //    文字内容
    CGSize size = [self sizeWithText:_dongmanData.title font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    _contentLabel.frame = CGRectMake(10, 10+_touxiangPicW+10, kScreenWidth, size.height);
    
    [super layoutSubviews];
    CGFloat LQSMargin = 10;
     _picW = (kScreenWidth - 4 * LQSMargin)/3;
    //计算图片的frame
    NSUInteger count;
    if (_picViewArr.count <= 3) {
        count = _picViewArr.count;
    }else{
        count = 3;
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        //    计算有多少行
        NSUInteger rows = i /3;
        //    计算有多少咧
        NSUInteger cols = i % 3;
        

        UIView *userView = [_imageViews objectAtIndex:i];
        userView.tag = i;
        userView.width = _picW;
        userView.height = _picW;
        userView.frame = CGRectMake(cols * (LQSMargin + _picW) + LQSMargin, rows * (LQSMargin + _picW) + LQSMargin + CGRectGetMaxY(_contentLabel.frame), _picW, _picW);
    }
    
    
    CGFloat tooY;
    if (_picViewArr.count <= 0) {
        tooY = CGRectGetMaxY(_contentLabel.frame) + LQSMargin ;

    }else {
        tooY = CGRectGetMaxY(_contentLabel.frame) + 2 * LQSMargin + _picW;
    }
//    else if (_picViewArr.count > 3 && _picViewArr.count <= 6){
//        tooY = CGRectGetMaxY(_contentLabel.frame) + 3 * LQSMargin + _picW * 2;
//    
//    }else if (_picViewArr.count > 6 && _picViewArr.count <= 9){
//        tooY = CGRectGetMaxY(_contentLabel.frame) + 4 * LQSMargin + _picW * 3;
    
//    }
    
    
    
    
    
    
    //    添加评论数
    _pinglunLabel.frame = CGRectMake(kScreenWidth - 40, tooY, 40, 20);
//    添加评论图片
    _pinglunPic.frame = CGRectMake(kScreenWidth - 40 - 20, tooY, 20, 20);
    //    添加点击量
    _fangwenLabel.frame = CGRectMake(kScreenWidth - 80 - 20 , tooY, 40, 20);
//    添加访问图片
    _fangwenPic.frame = CGRectMake(kScreenWidth - 80 - 20 - 20, tooY, 20, 20);


}

- (CGFloat)cellHeight{
    CGFloat cellHeight;
    _touxiangPicW = 30;
    _picW = (kScreenWidth - 4 * LQSMargin)/3;
    CGSize size = [self sizeWithText:_dongmanData.title font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    if (_picViewArr.count <= 0) {
        cellHeight = _touxiangPicW + size.height  + 2 * LQSMargin + LQSMargin + 20;
    }else {
        cellHeight = _touxiangPicW + size.height + 3 * LQSMargin + _picW+ LQSMargin+ 20;
    }
//    else if (_picViewArr.count <= 6){
//        cellHeight = _touxiangPicW + size.height + 4 * LQSMargin + _picW * 2+ LQSMargin+ 20;
//    }else{
//        cellHeight = _touxiangPicW + size.height + 5 * LQSMargin + _picW * 3+ LQSMargin+ 20;
//
//    }
    return cellHeight;

}

@end
