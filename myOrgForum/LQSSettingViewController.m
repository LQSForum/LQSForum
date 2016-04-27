//
//  LQSSettingViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSettingViewController.h"
#import "LQSUITableView.h"
#import "LQSSettingCell.h"
#import "LQSSettingModel.h"
@interface LQSSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)LQSUITableView *tableView;

@end

@implementation LQSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView setRefresh];
    
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
    



    return cell;

}
@end
