

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
//        [self setRefresh];
        [self setup];
    }
    return self;

}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setup];
//        [self setRefresh];
    }
    return self;



}

- (void)setup
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentInset = UIEdgeInsetsZero;
    }

- (void)setRefresh
{
    __unsafe_unretained UITableView *tableView = self;
//    下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
                [tableView reloadData];
                // 结束刷新
                [tableView.mj_header endRefreshing];

        });
    }];
//设置自动切换透明度
    tableView.mj_header.automaticallyChangeAlpha = YES;
    [tableView.mj_header beginRefreshing];

//    上啦刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tableView reloadData];
            [tableView.mj_footer endRefreshing];
        });
        
    }];
    // 默认先隐藏footer
    tableView.mj_footer.hidden = YES;

}

@end
