//
//  LQSEmotionPopView.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQSEmotionView;
@interface LQSEmotionPopView : UIView

+ (instancetype)popView;

/**
 *  显示表情弹出控件
 *
 *  @param emotionView 从哪个表情上面弹出
 */
- (void)showFromEmotionView:(LQSEmotionView *)fromEmotionView;
- (void)dismiss;

@end
