//
//  UIWindow+Extension.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "LQSNewfeatureViewController.h"
#import "LQSTabBarViewController.h"
@implementation UIWindow (Extension)

- (void)chooseRootViewController{
//沙盒版本号
    NSString *key = @"CFBundleVersion";
//    获取上次使用的key
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]
                                            objectForKey:key];

//当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([lastVersion isEqualToString:currentVersion]) {
        self.rootViewController = [[LQSTabBarViewController alloc] init];
        
    }else{
    
        self.rootViewController = [[LQSNewfeatureViewController alloc] init];
        //将当前的版本号存到沙盒里面
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    }

}
@end
