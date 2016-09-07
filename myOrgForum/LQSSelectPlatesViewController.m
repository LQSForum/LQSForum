//
//  LQSSelectPlatesViewController.m
//  myOrgForum
//
//  Created by 周双 on 16/9/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSelectPlatesViewController.h"

@interface LQSSelectPlatesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    
    
    
}
@end

@implementation LQSSelectPlatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    //   创建tableview
    [self createTableView];
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark tableViewDelegate&dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
    
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    
    return 2;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"selectPlatesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
    
    
    
    
    
    
    
    
    
}


@end
