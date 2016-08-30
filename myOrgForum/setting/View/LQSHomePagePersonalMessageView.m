//
//  LQSHomePagePersonalMessageView.m
//  myOrgForum
//
//  Created by 周双 on 16/8/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//伸缩的背景墙

#import "LQSHomePagePersonalMessageView.h"

@interface LQSHomePagePersonalMessageView()
{
    CGRect initialFrame;
    CGFloat defaultViewHeight;
}
@end


@implementation LQSHomePagePersonalMessageView

@synthesize tableView = _tableView;
@synthesize view = _view;



- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view subViews:(UIView*)subview
{
    _tableView = tableView;
    _view      = view;
    
    initialFrame       = _view.frame;
    defaultViewHeight  = initialFrame.size.height;
    
    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    
    _tableView.tableHeaderView = emptyTableHeaderView;
    
    [_tableView addSubview:_view];
    [_tableView addSubview:subview];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGRect f     = _view.frame;
    f.size.width = _tableView.frame.size.width;
    _view.frame  = f;
    
    if(scrollView.contentOffset.y < 0)
    {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        
        initialFrame.origin.y = - offsetY * 1;
        initialFrame.origin.x = - offsetY / 2;
        
        initialFrame.size.width  = _tableView.frame.size.width + offsetY;
        initialFrame.size.height = defaultViewHeight + offsetY;
        
        _view.frame = initialFrame;
    }
    
}


- (void)resizeView
{
    initialFrame.size.width = _tableView.frame.size.width;
    _view.frame = initialFrame;
}

@end