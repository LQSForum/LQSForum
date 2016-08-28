//
//  LQSAddViewHelper.m
//  myOrgForum
//
//  Created by XJW on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSAddViewHelper.h"

@implementation LQSAddViewHelper

+ (void)addImageView:(UIImageView **)imageView frame:(CGRect)frame tag:(NSInteger)tag superView:(UIView *)superView imgUrlStr:(NSString *)urlStr selector:(SEL)selector
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    [superView addSubview:imgView];
    imgView.tag = tag;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(urlStr)] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        imgView.image = image;
    }];
    if (tag != 0) {
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
        [imgView addGestureRecognizer:tap];
    }
    
    *imageView = imgView;
}

- (void)addLable:(UILabel **)lable withFrame:(CGRect)frame text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment )alignment lineNumber:(NSInteger)number tag:(NSInteger)tag superView:(UIView *)supView
{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = text;
    lab.textColor = color;
    lab.font = font;
    lab.textAlignment = alignment;
    lab.tag = tag;
    lab.numberOfLines = number;
    [supView addSubview:lab];
    if (lable) {
        *lable = lab;
    }
    lab.backgroundColor = [UIColor clearColor];
}
- (void)addLine:(UIView **)lineView withFrame:(CGRect)frame superView:(UIView *)superView color:(UIColor *)color
{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    [superView addSubview:line];
    line.backgroundColor = color;
    *lineView = line;
}

@end
