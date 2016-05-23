//
//  LQSMessageViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSMessageViewController.h"

@interface LQSMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    LQSUITableView *_messageTableView;


}

@end

@implementation LQSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
//    创建tableView
    [self createTableView];
    
}

- (void)createTableView
{
    _messageTableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, LQSNavBarBottom, self.view.width, self.view.height - LQSNavBarBottom) style:UITableViewStylePlain];
    _messageTableView.delegate = self;
    [self.view addSubview:_messageTableView];



}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString *identifier = @"messageTableViewCell";
    LQSMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LQSMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
