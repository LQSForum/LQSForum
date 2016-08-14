
//
//  LQSPhotosView.m
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPhotosView.h"
#define IWPhotosMaxCols(count) ((count == 4) ? 2 : 3)

@implementation LQSPhotosView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 一次性创建9个
        for (int i = 0; i < 9; i++) {
            // 1.创建photoView
            LQSPhotoView *photoView = [[LQSPhotoView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 2.添加点击事件
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
        }
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
    for (int i = 0; i<self.photos.count; i++) {
        // 取出图片模型
        LQSPhoto *photo = self.photos[i];
        
        // 创建MJPhoto模型
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        // 设置图片的url
        mjphoto.url = [NSURL URLWithString:photo.bmiddle_pic];
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
    
    // 0.可见的控件
    int photosCount = photos.count;
    if (photosCount == 0) {
        self.hidden = YES;
        return;
    } else {
        self.hidden = NO;
    }
    
    // 1.给图片控件显示图片(遍历所有的子控件)
    for (int i = 0; i < 9; i++) {
        LQSPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // i <photosCount 显示图片
            photoView.hidden = NO;
            photoView.photo = photos[i];
        } else { // i >= photosCount 隐藏
            photoView.hidden = YES;  // 还在父控件的subviews数组中移除(还在内存中)
        }
        //        [photoView removeFromSuperview]; // 从父控件的subviews数组中移除(从内存中移除)
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.photos.count;
    
    for (int i = 0; i < count; i++) {
        // 取出子控件
        LQSPhotoView *photoView = self.subviews[i];
        
        // 设置frame
        photoView.width = 70;
        photoView.height = 70;
        
        // 一行最多的列数
        int maxCols = IWPhotosMaxCols(count);
        
        // x 取决于 列数
        int col = i % maxCols;
        photoView.x = col * (70 + 10);
        // y 取决于 行数
        int row = i / maxCols;
        photoView.y = row * (70 + 10);
        //        UIView *view = [[UIView alloc] init];
        //        view.backgroundColor = [UIColor blueColor];
        //        view.frame = photoView.bounds;
        //        [photoView addSubview:view];
    }
}

@end
