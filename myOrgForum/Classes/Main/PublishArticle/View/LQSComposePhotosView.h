//
//  LQSComposePhotosView.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQSComposePhotosView;
@protocol jmpPickVCDelegate <NSObject>

- (void)jmpPickVC:(LQSComposePhotosView *)composePhotoView;

@end
@interface LQSComposePhotosView : UIView

@property (nonatomic, weak)id<jmpPickVCDelegate> delegate;
/**
 *  添加一张图片到相册内部
 *
 *  @param image 新添加的图片
 */
- (void)addImage:(UIImage *)image;

- (NSArray *)images;

@end
