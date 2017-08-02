//
//  LQSForumAttentionOnePictureView.m
//  myOrgForum
//
//  Created by 昱含 on 2017/5/12.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSAttentionOnePictureView.h"

@implementation LQSAttentionOnePictureView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPictureURL:(NSString *)pictureURL
{
    _pictureURL = pictureURL;
    
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:pictureURL] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
}



@end
