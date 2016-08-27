//
//  UIColor+Hex.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)lqs_colorWithHex:(uint)hex
{
    if (hex <= 0xffffff) {
        hex = 0xff000000 | hex;
    }
    return [UIColor lqs_colorWithARGBHex:hex];
}

+ (UIColor *)lqs_colorWithARGBHex:(uint)hex
{
    int red, green, blue, alpha;
    
    blue = hex & 0x000000FF;
    green = ((hex & 0x0000FF00) >> 8);
    red = ((hex & 0x00FF0000) >> 16);
    alpha = ((hex & 0xFF000000) >> 24);
    
    return [UIColor colorWithRed:red/255.0f
                           green:green/255.0f
                            blue:blue/255.0f
                           alpha:alpha/255.f];
}

+ (UIColor *)lqs_colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    
    NSScanner *scanner = [NSScanner scannerWithString:cString];
    unsigned int hex;
    BOOL success = [scanner scanHexInt:&hex];
    if (!success) {
        return [UIColor whiteColor];
    }
    
    return [self lqs_colorWithHex:hex];
}

+ (UIColor *)lqs_themeColor{
    return [UIColor lqs_colorWithHex:0x42c2f7];
}

@end
