//
//  LQSEmotionAttacLQSent.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSEmotionAttachment.h"

@implementation LQSEmotionAttachment
- (void)setEmotion:(LQSEmotion *)emotion
{
    _emotion = emotion;
    /* 之前的拼接方法，以后估计用不到了。
     self.image = [UIImage imageWithName:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
     */
    self.image = [UIImage imageWithName:[NSString stringWithFormat:@"%@", emotion.png]];
}

@end
