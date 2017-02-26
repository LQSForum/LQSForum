//
//  LQSReportDetailViewController.m
//  myOrgForum
//  功能:举报详情页,由帖子详情页push过来.
//  Created by Queen_B on 2016/11/13.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSReportDetailViewController.h"
// 标题
#define kNAVITitle @"举报主题"
@interface LQSReportDetailViewController ()

@end

@implementation LQSReportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kNAVITitle;
    self.view.backgroundColor = [UIColor whiteColor];
    // 隐藏右边的更多按钮.
    self.navigationItem.rightBarButtonItem = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
