
//
//  LQSDetailSettingViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSDetailSettingViewController.h"

@interface LQSDetailSettingViewController ()<UITableViewDelegate , UITableViewDataSource>
{
    LQSUITableView *_tableView;

}

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LQSDetailSettingViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        LQSSettingPersonalSettingDataModel *model1 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model1.imageName = @"";
        model1.title = @"修改密码";
        LQSSettingPersonalSettingDataModel *model2 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model2.imageName = @"";
        model2.title = @"回复提示通知";

        LQSSettingPersonalSettingDataModel *model3 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model3.imageName = @"";
        model3.title = @"@提示通知";

        LQSSettingPersonalSettingDataModel *model4 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model4.imageName = @"";
        model4.title = @"提示音";

        LQSSettingPersonalSettingDataModel *model5 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model5.imageName = @"";
        model5.title = @"位置信息";
        model5.subTitle = @"关闭后，您则不会出现在周边用户和周边帖子";
        LQSSettingPersonalSettingDataModel *model6 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model6.imageName = @"";
        model6.title = @"分享";

        LQSSettingPersonalSettingDataModel *model7 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model7.imageName = @"";
        model7.title = @"清理缓存";

        LQSSettingPersonalSettingDataModel *model8 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model8.imageName = @"";
        model8.title = @"关于";

        [self.dataSource addObject:model1];
        [self.dataSource addObject:model2];
        [self.dataSource addObject:model3];
        [self.dataSource addObject:model4];
        [self.dataSource addObject:model5];
        [self.dataSource addObject:model6];
        [self.dataSource addObject:model7];
        [self.dataSource addObject:model8];
    }

    return _dataSource;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人设置";
    [self createTableView];
}

- (void)createTableView
{
    _tableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - LQSNavBarBottom) style:UITableViewStylePlain];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];


}


#pragma mark - tableViewDelegate & tableViewDasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"settingPersonalSettingIdentifier";
    LQSSettingPersonalSettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LQSSettingPersonalSettingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell pushesSettingPersonalSettingModel:[self.dataSource objectAtIndex:indexPath.row]];
    if (indexPath.row == 1 || indexPath.row == 2 ||indexPath.row == 3||indexPath.row == 4) {

    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(50, 100, 20, 10)];
            [switchButton setOn:YES];
        cell.accessoryView = switchButton;
    }
        return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 50;
}
@end
