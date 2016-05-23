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
    LQSMessageDataModel *_dateModel;

}

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LQSMessageViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        LQSMessageDataModel *modle1 = [[LQSMessageDataModel alloc] init];
        modle1.iamgeName = @"";
        modle1.title = @"提到我的";
        
        LQSMessageDataModel *modle2 = [[LQSMessageDataModel alloc] init];
        modle2.iamgeName = @"";
        modle2.title = @"评论";
        
        LQSMessageDataModel *modle3 = [[LQSMessageDataModel alloc] init];
        modle3.iamgeName = @"";
        modle3.title = @"好友申请";
        
        [_dataSource addObject:modle1];
        [_dataSource addObject:modle2];
        [_dataSource addObject:modle3];
        
    }

    return _dataSource;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
//    创建tableView
    [self createTableView];
    
}

- (void)createTableView
{
    _messageTableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - LQSNavBarBottom) style:UITableViewStyleGrouped];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    [self.view addSubview:_messageTableView];



}

#pragma mark - tableViewDelegate & tableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString *identifier = @"messageTableViewCell";
    LQSMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LQSMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell PushesmessageTableViewModel:[self.dataSource objectAtIndex:indexPath.row]];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;
}

@end
