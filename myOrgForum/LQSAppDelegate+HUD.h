//
//  LQSAppDelegate+HUD.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSAppDelegate.h"

@interface LQSAppDelegate (HUD)
//显示HUD信息
- (void)showHUDMessage:(NSString *)message hideDelay:(NSTimeInterval)delay;
//去掉HUD
- (void)removeHUDDelay:(NSTimeInterval)delay;
//提示消息后隐藏HUD
- (void)showHUDToView:(UIView *)view
              message:(NSString *)message
            hideDelay:(NSTimeInterval)delay;
//从view上移除HUD
- (void)removeHUDFromViewDelay:(NSTimeInterval)delay;
@end
