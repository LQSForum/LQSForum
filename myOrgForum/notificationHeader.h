//
//  notificationHeader.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#ifndef notificationHeader_h
#define notificationHeader_h

#define LQSNotificationCenter\
                       [NSNotificationCenter defaultCenter]

#define LQSNotificationCenterPost(name,data)\
                             [LQSNotificationCenter\
                                 postNotificationName:name\
                                                 object:data]
#endif /* notificationHeader_h */
