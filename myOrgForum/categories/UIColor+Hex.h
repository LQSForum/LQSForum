//
//  UIColor+Hex.h
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)lqs_colorWithHex:(uint) hex;
+ (UIColor *)lqs_colorWithARGBHex:(uint) hex;
+ (UIColor *)lqs_colorWithHexString:(NSString *)stringToConvert;

@end
