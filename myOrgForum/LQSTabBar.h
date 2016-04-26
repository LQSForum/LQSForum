//
//  LQSTabBar.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LQSTabBar;
@protocol LQSTabBarDelegate<UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(LQSTabBar *)tabBar;

@end




@interface LQSTabBar : UITabBar
@property (nonatomic, weak) id<LQSTabBarDelegate>delegate;

@end
