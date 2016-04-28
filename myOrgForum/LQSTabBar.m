
//
//  LQSTabBar.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSTabBar.h"

@interface LQSTabBar()
@property (nonatomic, weak) UIButton *plusBtn;


@end
@implementation LQSTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        添加一个按钮到tabbar中
        UIButton *plusButton = [[UIButton alloc] init];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.size = plusButton.currentBackgroundImage.size;
        [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusButton];
        self.plusBtn = plusButton;
        
    }
    return self;
}

- (void)plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
        
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
//     设置其他tabbarButton的位置和尺寸
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *childView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([childView isKindOfClass:class]) {
//            设置宽度
            childView.width = tabBarButtonW;
//             设置X
            childView.x = tabBarButtonIndex * tabBarButtonW;
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
}
@end
