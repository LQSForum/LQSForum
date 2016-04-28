

//
//  LQSTableView.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSUITableView.h"
@implementation LQSUITableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setRefresh];
    }
    return self;

}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setRefresh];
    }
    return self;



}

- (void)setup
{
    self.backgroundColor = LQSColor(234, 37, 37);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth;
    self.contentInset = UIEdgeInsetsZero;
   
}

- (void)setRefresh
{
    __unsafe_unretained UITableView *tableView = self;
//    下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [tableView.mj_header endRefreshing];
        });
    }];
//设置自动切换透明度
    tableView.mj_header.automaticallyChangeAlpha = YES;
//    上啦刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [tableView.mj_footer endRefreshing];
        });
        
    }];
}

@end
