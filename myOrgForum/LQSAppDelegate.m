//
//  LQSAppDelegate.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSAppDelegate.h"
@interface LQSAppDelegate()


@end

@implementation LQSAppDelegate
+ (LQSAppDelegate *)shareAppDelegate
{
    return (LQSAppDelegate *)[UIApplication sharedApplication].delegate;
    
}



@end
