//
//  LQSHomePagePersonalMessageView.h
//  myOrgForum
//
//  Created by 周双 on 16/8/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSHomePagePersonalMessageView : NSObject
@property (nonatomic,retain) UITableView* tableView;
@property (nonatomic,retain) UIView* view;

/**
 * subview:内容部分
 * view   :拉伸的背景图片
 */
- (void)stretchHeaderForTableView:(UITableView*)tableView
                         withView:(UIView*)view
                         subViews:(UIView*)subview;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

- (void)resizeView;

@end

/*
 *使用时要实现以下两个代理方法
 *- (void)scrollViewDidScroll:(UIScrollView *)scrollView
 *- (void)viewDidLayoutSubviews
 */