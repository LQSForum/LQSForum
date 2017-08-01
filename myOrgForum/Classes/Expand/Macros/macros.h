//
//  macros.h
//  myOrgForum
//
//  Created by 昱含 on 2017/8/1.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//



//颜色
#define LQSColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//全局背景色
#define LQSGlobalBg LQSColor(211,211,211,1)
// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
/** 表情相关 */
// 表情的最大行数
#define LQSEmotionMaxRows 3
// 表情的最大列数
#define LQSEmotionMaxCols 7
// 每页最多显示多少个表情
#define LQSEmotionMaxCountPerPage (LQSEmotionMaxRows * LQSEmotionMaxCols - 1)

// 通知
// 表情选中的通知
#define LQSEmotionDidSelectedNotification @"LQSEmotionDidSelectedNotification"
// 点击删除按钮的通知
#define LQSEmotionDidDeletedNotification @"LQSEmotionDidDeletedNotification"
// 通知里面取出表情用的key
#define LQSSelectedEmotion @"LQSSelectedEmotion"

// 链接选中的通知
#define LQSLinkDidSelectedNotification @"LQSLinkDidSelectedNotification"

// 富文本里面出现的链接
#define LQSLinkText @"LQSLinkText"
// 屏幕尺寸
#define LQSScreenW [UIScreen mainScreen].bounds.size.width
#define LQSScreenH [UIScreen mainScreen].bounds.size.height
//屏幕宽高
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


