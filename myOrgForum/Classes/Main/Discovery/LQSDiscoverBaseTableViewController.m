//
//  LQSDiscoverBaseTableViewController.m
//  myOrgForum
//
//  Created by g x on 2017/7/18.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSDiscoverBaseTableViewController.h"
#define headerImgHeight kScreenWidth/2 // 头部图片刚开始显示的高度
#define topBarHeight 64  // 导航栏加状态栏高度
#define switchBarHeight 35
@interface LQSDiscoverBaseTableViewController ()

@end

@implementation LQSDiscoverBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.showsHorizontalScrollIndicator  = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerImgHeight + switchBarHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    /*
     if (self.tableView.contentSize.height < kScreenHeight + headerImgHeight - topBarHeight ) {
     self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kScreenHeight + headerImgHeight - topBarHeight - self.tableView.contentSize.height, 0);
     }
     */


}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    // NSLog(@"%f", offsetY);
    
    if ([self.delegate respondsToSelector:@selector(tableViewScroll:offsetY:)]) {
        [self.delegate tableViewScroll:self.tableView offsetY:offsetY];
    }
}



@end
