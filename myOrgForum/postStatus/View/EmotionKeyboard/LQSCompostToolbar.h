//
//  LQSCompostToolbar.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum {
    LQSComposeToolbarButtonTypeCamera, // 照相机
    LQSComposeToolbarButtonTypePicture, // 相册
    LQSComposeToolbarButtonTypeMention, // 提到@
    LQSComposeToolbarButtonTypeTrend, // 话题
    LQSComposeToolbarButtonTypeEmotion // 表情
} LQSComposeToolbarButtonType;

@class LQSComposeToolbar;

@protocol LQSComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(LQSComposeToolbar *)toolbar didClickedButton:(LQSComposeToolbarButtonType)buttonType;

@end

@interface LQSComposeToolbar : UIView
@property (nonatomic, weak) id<LQSComposeToolbarDelegate> delegate;
/**
 *  设置某个按钮的图片
 *
 *  @param image      图片名
 *  @param buttonType 按钮类型
 */
//- (void)setButtonImage:(NSString *)image buttonType:(LQSComposeToolbarButtonType)buttonType;

/**
 *  是否要显示表情按钮
 */
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;
@end

