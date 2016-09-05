//
//  NSTextAttachment+ArticleContent.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/31.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "NSTextAttachment+ArticleContent.h"
static char kTextAttachmentItem;
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

- (void)setUrl:(NSString *)url{
    objc_setAssociatedObject(self, &kTextAttachmentItem, url, OBJC_ASSOCIATION_COPY);
}

- (NSString*)url{
    id item = objc_getAssociatedObject(self, &kTextAttachmentItem);
    if (item == nil) {
        return @"";
    }
    return item;
}

@end
