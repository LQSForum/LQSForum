//
//  LQSCishanStatusTopView.m
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSCishanStatusTopView.h"

@interface LQSCishanStatusTopView()
@property (nonatomic, weak) LQSCishanStatusOriginView *originalView;

@end
@implementation LQSCishanStatusTopView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.原创微博的view
        [self setupOriginalView];
        
        
        // 3.设置图片
        self.userInteractionEnabled = YES;
    }
    return self;
}

/**
 *  添加原创微博的view
 */
- (void)setupOriginalView
{
    LQSCishanStatusOriginView *originalView = [[LQSCishanStatusOriginView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
}


- (void)setCishanStatusFrame:(LQSCishanModelFrame *)cishanStatusFrame{
    _cishanStatusFrame = cishanStatusFrame;
    
    // 设置顶部控件的view
    self.frame = cishanStatusFrame.topViewF;
    
    self.originalView.cishanStatusFrame = cishanStatusFrame;
}

@end
