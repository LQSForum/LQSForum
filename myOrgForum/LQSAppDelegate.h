//
//  LQSAppDelegate.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LQSAppDelegate : UIResponder
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) MBProgressHUD *viewHUD;

+ (LQSAppDelegate *)shareAppDelegate;

@end
