//
//  LQSTextView.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSTextView : UITextView
@property (nonatomic, copy) NSString *placehoder;
@property (nonatomic, strong) UIColor *placehoderColor;

// textView最大行数
@property (nonatomic, assign) NSUInteger maxNumberOfLines;
/**
 *  文字高度改变block → 文字高度改变会自动调用
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, strong) void(^lqs_textHeightChangeBlock)(NSString *text,CGFloat textHeight);

// 设置圆角
@property (nonatomic, assign) NSUInteger cornerRadius;


@end
