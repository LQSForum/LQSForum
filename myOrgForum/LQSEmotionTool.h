//
//  LQSEmotionTool.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LQSEmotion;

@interface LQSEmotionTool : NSObject
/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;

/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (LQSEmotion *)emotionWithDesc:(NSString *)desc;

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(LQSEmotion *)emotion;

@end
