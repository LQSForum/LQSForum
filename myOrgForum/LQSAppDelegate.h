//
//  LQSAppDelegate.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSAppDelegate : UIResponder
@property (nonatomic, strong) UIWindow *window;

+ (LQSAppDelegate *)shareAppDelegate;

//显示HUD内容
- (void)showHUDMessage:(NSString *)message hideDelay:(NSTimeInterval *)delay;
//去掉HUD内容
- (void)removeHUDDelay:(NSTimeInterval *)delay;
@end
