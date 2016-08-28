//
//  LQSForumDetailSectionHeadView.h
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LQSForumDetailSection;
@interface LQSForumDetailSectionHeadView : UIView

- (void)re

@end

@protocol LQSForumDetailSection <NSObject>

- (void)selectTheType:(NSInteger)type;

@end