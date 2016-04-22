//
//  LQSAppDelegate.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSAppDelegate.h"

@interface LQSAppDelegate()
{
//    MBProgressHUD *_hud;

}

@end

@implementation LQSAppDelegate
+ (LQSAppDelegate *)shareAppDelegate
{
    return (LQSAppDelegate *)[UIApplication sharedApplication].delegate;
    
}

- (void)showHUDMessage:(NSString *)message hideDelay:(NSTimeInterval *)delay
{
    [self removeHUDDelay:0];
    


}

- (void)removeHUDDelay:(NSTimeInterval *)delay
{





}



@end
