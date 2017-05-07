//
//  LQSEmotionKeyboard.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSEmotionKeyboard.h"


@interface LQSEmotionKeyboard()

/** 表情列表 */
@property (nonatomic, weak) LQSEmotionListView *listView;
/** 表情工具条 */
@property (nonatomic, weak) LQSEmotionToolbar *toollbar;

@property (nonatomic, strong) NSArray *emojiArr;



@end
@implementation LQSEmotionKeyboard
+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"emoticon_keyboard_background"]];
        
        // 1.添加表情列表
        LQSEmotionListView *listView = [[LQSEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 配置表情集合
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"lqsemoji.plist" ofType:nil];
        _emojiArr = [LQSEmotion mj_objectArrayWithFile:plist];//goback
        //[_emojiArr makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
        //NSLog(@"emojiArr:%@",_emojiArr);
        
        self.listView.emotions = _emojiArr;
        // 注释：本来工具条已经加上了，后来对比线上版发现完全不是一回事，既没有工具条，表情更是一个都不同，那这些代码就都注释掉了。
        /*
        // 2.添加表情工具条
        LQSEmotionToolbar *toollbar = [[LQSEmotionToolbar alloc] init];
        toollbar.delegate = self;
        [self addSubview:toollbar];
        self.toollbar = toollbar;
         */
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    /*
    // 1.设置工具条的frame
    self.toollbar.width = self.width;
    self.toollbar.height = 35;
    self.toollbar.y = self.height - self.toollbar.height;
    */
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.height;
}

#pragma mark - LQSEmotionToolbarDelegate
- (void)emotionToolbar:(LQSEmotionToolbar *)toolbar didSelectedButton:(LQSEmotionType)emotionType
{
    switch (emotionType) {
        case LQSEmotionTypeDefault:// 默认
            self.listView.emotions = [LQSEmotionTool defaultEmotions];
            break;
            
        case LQSEmotionTypeEmoji: // Emoji
            self.listView.emotions = [LQSEmotionTool emojiEmotions];
            break;
            
        case LQSEmotionTypeLxh: // 浪小花
            self.listView.emotions = [LQSEmotionTool lxhEmotions];
            break;
            
        case LQSEmotionTypeRecent: // 最近
            self.listView.emotions = [LQSEmotionTool recentEmotions];
            break;
    }
}
@end
