//
//  NSTextAttachment+ArticleContent.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/31.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "NSTextAttachment+ArticleContent.h"

@implementation LQSTextAttachment

@end

@implementation NSTextAttachment (ArticleContent)

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock{
    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageHighPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (error == nil) {
            weakSelf.image = image;
            completedBlock(image,error,cacheType,imageURL);
        }
    }];
}

@end
