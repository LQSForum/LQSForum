//
//  parametersHeader.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/11.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#ifndef parametersHeader_h
#define parametersHeader_h

//pragma mark - delegate

#define kAppDelegate  [LQSAppDelegate shareAppDelegate]
#define kApp          [UIApplication sharedApplication]

//网络是否可用
#define kNetworkIsReached   [AFNetworkReachabilityManager sharedManager].reachable

#define kNetworkNotReachedMessage  [kAppDelegate showHUDMessage:@"网络好像有点问题" hideDelay:1.0]

//device uuid
#define kUUID          [[UIDevice currentDevice] identifierForVendor].UUIDString















#endif /* parametersHeader_h */
