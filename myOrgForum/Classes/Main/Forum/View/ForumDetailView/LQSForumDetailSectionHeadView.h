//
//  LQSForumDetailSectionHeadView.h
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LQSForumDetailSectionDelegete;

@interface LQSForumDetailSectionHeadView : UIView
@property (nonatomic, readwrite, weak) id<LQSForumDetailSectionDelegete> delegate;

- (void)removeSubForum;

@end

@protocol LQSForumDetailSectionDelegete <NSObject>

- (void)selectTheType:(NSInteger)type;

@end