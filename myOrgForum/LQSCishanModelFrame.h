//
//  LQSCishanModelFrame.h
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LQSCishanListModel;

@interface LQSCishanModelFrame : NSObject
@property (nonatomic,strong)LQSCishanListModel *cishanStatus;
/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;

/** 原创微博的view */
@property (nonatomic, assign, readonly) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photosViewF;

/** 底部的工具条 */
@property (nonatomic, assign, readonly) CGRect toolbarF;


/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
