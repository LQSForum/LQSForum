//
//  LQSSettingViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSettingViewController.h"

@interface LQSSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)LQSUITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LQSSettingViewController

- (NSMutableArray *)dataSource
{

    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        LQSSettingModel *model = [[LQSSettingModel alloc] init];
        model.iamge = @"";//
        model.title = @"CCC";//
        LQSSettingModel *model2 = [[LQSSettingModel alloc] init];
        model2.iamge = @"";
        model2.title = @"消息";
        LQSSettingModel *model3 = [[LQSSettingModel alloc] init];
        model3.iamge = @"setting_setting";
        model3.title = @"设置";
        
        [self.dataSource addObject:model];
        [self.dataSource addObject:model2];
        [self.dataSource addObject:model3];
    }

    return _dataSource;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    [self.tableView setRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -m tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

NSString *identifier = @"settingCellIdentifier";

    LQSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LQSSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        [cell pushSettingModel:self.dataSource[indexPath.row]];
    }else if (indexPath.section == 1){
        [cell pushSettingModel:self.dataSource[indexPath.row + 1]];
    
    }

    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

#pragma mark -m TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    if (indexPath.section == 0) {
      vc =  [[LQSMyHomePageViewController alloc] init];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        vc = [[LQSMessageViewController alloc] init];
    }else{
        vc = [[LQSDetailSettingViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:NO];
}


@end
