//
//  LQSEmotionTextView.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSTextView.h"
@class LQSEmotion;

@interface LQSEmotionTextView : LQSTextView
/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(LQSEmotion *)emotion;

/**
 *  具体的文字内容
 */
- (NSString *)realText;
@end
