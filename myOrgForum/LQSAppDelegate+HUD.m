//
//  LQSAppDelegate+HUD.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSAppDelegate+HUD.h"
#import "MBProgressHUD.h"
@implementation LQSAppDelegate (HUD)
//创建HUD
- (MBProgressHUD *)makeHUDAtView:(UIView *)view
                         message:(NSString *)message
                           delay:(NSTimeInterval)delay{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.margin = 10.0;
    hud.cornerRadius = 5.0;
    hud.opacity = 0.5;
    hud.yOffset -= 40;
    if (message && ![message isEqualToString:@""]) {
        hud.labelText = message;
        hud.mode = MBProgressHUDModeText;
    }
    
    if (delay != -1) {
        [hud hide:YES afterDelay:delay];
    }
    return hud;

}
//创建HUD
- (MBProgressHUD *)makeHUDAtView:(UIView *)view
                         message:(NSString *)message hudMode:(MBProgressHUDMode )mode{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.margin = 10.0;
    hud.bezelView.layer.cornerRadius = 5.0;
    hud.opacity = 0.5;
    hud.yOffset -= 40;
    if (message && ![message isEqualToString:@""]) {
        hud.labelText = message;
        hud.mode = mode;
    }
    return hud;
    
}

//移除HUD
- (void)removeHUD:(MBProgressHUD *)hud
            delay:(NSTimeInterval)delay{

    if (hud) {
//        [hud hide:YES afterDelay:delay];
        [hud hideAnimated:YES afterDelay:delay];
        [hud removeFromSuperViewOnHide];
        hud = nil;
    }
}
-(void) showIndicatorWithMessage:(NSString *)msg hudMode:(MBProgressHUDMode )mode{
    [self removeHUD:self.viewHUD delay:0];
    self.viewHUD = [self makeHUDAtView:self.window
                               message:msg hudMode:mode];
}
//显示HUD信息
- (void)showHUDMessage:(NSString *)message
             hideDelay:(NSTimeInterval)delay{
    [self removeHUD:self.viewHUD delay:0];
    self.viewHUD = [self makeHUDAtView:self.window
                               message:message
                                 delay:delay];
    

}
//去掉HUD
- (void)removeHUDDelay:(NSTimeInterval)delay{
    [self removeHUD:self.viewHUD delay:delay];


}
//提示消息后隐藏HUD
- (void)showHUDToView:(UIView *)view
              message:(NSString *)message
            hideDelay:(NSTimeInterval)delay{

    [self removeHUD:self.viewHUD delay:0];
    self.viewHUD = [self makeHUDAtView:view
                               message:message
                                 delay:delay];

}
//从view上移除HUD
- (void)removeHUDFromViewDelay:(NSTimeInterval)delay{

    [self removeHUD:self.viewHUD delay:delay];


}



@end
