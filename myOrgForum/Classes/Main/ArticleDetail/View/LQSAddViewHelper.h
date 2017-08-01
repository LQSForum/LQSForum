//
//  LQSAddViewHelper.h
//  myOrgForum
//
//  Created by XJW on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSAddViewHelper : NSObject

#pragma mark - 添加空间
//添加可点击的网络加载图片
+ (void)addImageView:(UIImageView **)imageView frame:(CGRect)frame tag:(NSInteger)tag image:(UIImage *)img superView:(UIView *)superView imgUrlStr:(NSString *)urlStr selector:(SEL)selector;
//添加lable
+ (void)addLable:(UILabel **)lable withFrame:(CGRect)frame text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment )alignment lineNumber:(NSInteger)number tag:(NSInteger)tag superView:(UIView *)supView;
//添加分割线
+ (void)addLine:(UIView **)lineView withFrame:(CGRect)frame superView:(UIView *)superView color:(UIColor *)color;

#pragma mark - 小工具
//计算特定字符出现的次数
+ (NSInteger)getCountOfString:(NSString *)string forCharacter:(NSString *)charaStr;
+ (NSString *)createDataDescriptionWithStr:(NSString *)string;
@end
