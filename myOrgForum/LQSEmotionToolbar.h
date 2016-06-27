//
//  LQSEmotionToolbar.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//  表情底部的工具条

#import <UIKit/UIKit.h>
@class LQSEmotionToolbar;

typedef enum {
    LQSEmotionTypeRecent, // 最近
    LQSEmotionTypeDefault, // 默认
    LQSEmotionTypeEmoji, // Emoji
    LQSEmotionTypeLxh // 浪小花
} LQSEmotionType;

@protocol LQSEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(LQSEmotionToolbar *)toolbar didSelectedButton:(LQSEmotionType)emotionType;
@end


@interface LQSEmotionToolbar : UIView
@property (nonatomic, weak) id<LQSEmotionToolbarDelegate> delegate;

@end
