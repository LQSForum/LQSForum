//
//  LQSForumAttentionPicturesView.h
//  myOrgForum
//
//  Created by 昱含 on 2017/5/12.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSAttentionPicturesView : UIView

@property(nonatomic,strong) NSArray *photos;
/**
 *  根据图片个数计算相册的尺寸
 */
+ (CGSize)sizeWithCount:(int)count;

@end
