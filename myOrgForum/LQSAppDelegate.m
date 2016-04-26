//
//  LQSAppDelegate.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSAppDelegate.h"
#import "UIWindow+Extension.h"
@interface LQSAppDelegate()


@end

@implementation LQSAppDelegate
+ (LQSAppDelegate *)shareAppDelegate
{
    return (LQSAppDelegate *)[UIApplication sharedApplication].delegate;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   [self.window chooseRootViewController];

    [self.window makeKeyAndVisible];
    return YES;
}



@end
