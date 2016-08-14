
//
//  LQSPhotoView.m
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPhotoView.h"

@interface LQSPhotoView()
@property (nonatomic, weak) UIImageView *gifView;

@end
@implementation LQSPhotoView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置属性
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出UIImageView边界的内容, 都剪掉(不显示)
        self.clipsToBounds = YES;
        //            photoView.layer.masksToBounds = YES;
        
        // 2.gifView
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(LQSPhoto *)photo
{
    _photo = photo;
    
    // 1.下载图片
    NSURL *photoUrl = [NSURL URLWithString:photo.thumbnail_pic];
    
    [self setImageWithURL:photoUrl placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
    // 2.gifView的可见性
    //photo.thumbnail_pic ==  http://weibo.com/abc.gif
    //photo.thumbnail_pic ==  http://weibo.com/abc.GIF
    
    //photo.thumbnail_pic.lowercaseString == http://weibo.com/abc.gif
    // 忽略大小写进行判断
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"]) {
        self.gifView.hidden = NO;
    } else {
        self.gifView.hidden = YES;
    }
    //    self.gifView.hidden = [photo.thumbnail_pic hasSuffix:@"gif"] == NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
