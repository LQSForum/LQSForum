//
//  LQSAccountManagementViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSAccountManagementViewController.h"
#import "LQSUserManager.h"
@interface LQSAccountManagementViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *_tableView;


}
@end

@implementation LQSAccountManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号管理";
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)createTableView{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];


}

#pragma mark - tableViewDelegate&DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *identifier = @"accountIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"登出";
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要退出登录吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [LQSUserManager clearUser];
        [kAppDelegate showHUDMessage:@"登出成功" hideDelay:2];
        [self.navigationController popViewControllerAnimated:NO];
    }



}
@end
