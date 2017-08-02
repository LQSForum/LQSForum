//
//  LQSForumAttentionPicturesView.m
//  myOrgForum
//
//  Created by 昱含 on 2017/5/12.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSAttentionPicturesView.h"
#import "LQSAttentionOnePictureView.h"

#define LQSAttentionPhotoMargin 10
#define LQSAttentionPhotoW (LQSScreenW-LQSMargin*4)/3;

@interface LQSAttentionPicturesView ()
{
    LQSAttentionOnePictureView *_photoView;
}

@end
@implementation LQSAttentionPicturesView

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    
    return self;
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
    for (int i = 0; i < self.photos.count; i++) {
        // 创建MJPhoto模型
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        // 设置图片的url
        mjphoto.url = [NSURL URLWithString:[self.photos objectAtIndex:i]];
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

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photosCount = (int)photos.count;
    
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
//    if (photosCount > 3 ) {
//        photosCount = 3;
//    }
    while (self.subviews.count < photosCount) {
        _photoView = [[LQSAttentionOnePictureView alloc] init];
        _photoView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
        [_photoView addGestureRecognizer:tapGesture];
        [self addSubview:_photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        _photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            _photoView.pictureURL = photos[i];
            _photoView.hidden = NO;
        } else { // 隐藏
            _photoView.hidden = YES;
        }
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    int photosCount = (int)self.photos.count;
    if (photosCount > 3) {
        photosCount = 3;
    }
    for (int i = 0; i < photosCount; i++) {
        _photoView = self.subviews[i];
        CGFloat pictureW = LQSAttentionPhotoW;
        _photoView.frame = CGRectMake(LQSMargin+(LQSMargin+pictureW)*i, 0, pictureW, pictureW);
    }
    
}

+ (CGSize)sizeWithCount:(int)count
{
    
    CGFloat photosW = count * LQSAttentionPhotoW;
    
    return CGSizeMake(photosW, photosW);
}



@end
