//
//  LQSEmotionToolbar.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//
#define LQSEmotionToolbarButtonMaxCount 4

#import "LQSEmotionToolbar.h"

@interface LQSEmotionToolbar()
/** 记录当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;

@end
@implementation LQSEmotionToolbar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加4个按钮
        [self setupButton:@"最近" tag:LQSEmotionTypeRecent];
        [self setupButton:@"默认" tag:LQSEmotionTypeDefault];
        [self setupButton:@"Emoji" tag:LQSEmotionTypeEmoji];
        [self setupButton:@"浪小花" tag:LQSEmotionTypeLxh];
        
        // 2.监听表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:LQSEmotionDidSelectedNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  表情选中
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    if (self.selectedButton.tag == LQSEmotionTypeRecent) {
        [self buttonClick:self.selectedButton];
    }
}

/**
 *  添加按钮
 *
 *  @param title 按钮文字
 */
- (UIButton *)setupButton:(NSString *)title tag:(LQSEmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 添加按钮
    [self addSubview:button];
    
    // 设置背景图片
    int count = self.subviews.count;
    if (count == 1) { // 第一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (count == LQSEmotionToolbarButtonMaxCount) { // 最后一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    } else { // 中间按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return button;
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    // 1.控制按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:button.tag];
    }
}

- (void)setDelegate:(id<LQSEmotionToolbarDelegate>)delegate
{
    _delegate = delegate;
    
    // 获得“默认”按钮
    UIButton *defaultButton = (UIButton *)[self viewWithTag:LQSEmotionTypeDefault];
    // 默认选中“默认”按钮
    [self buttonClick:defaultButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置工具条按钮的frame
    CGFloat buttonW = self.width / LQSEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i<LQSEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}

@end
