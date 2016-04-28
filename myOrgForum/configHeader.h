
//
//  configHeader.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#ifndef configHeader_h
#define configHeader_h

//系统版本
#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define kIsSimulator [[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)
#define kios7System 8.0 > KSystemVersion && kSystemVersion >= 7.0
#define kios6System kSystemVersion < 7.0
#define kios8System kSystemVersion >= 8.0
//屏幕宽高
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif /* configHeader_h */
