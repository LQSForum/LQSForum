//
//  LQLoginViewController.h
//  myOrgForum
//
//  Created by su on 16/8/9.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "rootViewController.h"

@interface LQLoginViewController : rootViewController<UIAlertViewDelegate>
{
    NSString *inputUserName;
    NSString *inputPSW;
}
@end
