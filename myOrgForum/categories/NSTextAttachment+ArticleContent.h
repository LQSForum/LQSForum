//
//  NSTextAttachment+ArticleContent.h
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/31.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSTextAttachment (ArticleContent)

@property (nonatomic, readwrite, strong) NSString *url;

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock;

@end
