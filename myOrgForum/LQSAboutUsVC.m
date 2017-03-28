//
//  LQSAboutUsVC.m
//  myOrgForum
//
//  Created by lsm on 17/3/24.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSAboutUsVC.h"
#import "LQSAboutUsModel.h"
#import "LQSWebVC.h"

@interface LQSAboutUsVC ()<UITableViewDelegate,UITableViewDataSource>{
    int width;
    int height;
    UITableView * listView;
    NSMutableArray * array;
}

@end

@implementation LQSAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
#pragma mark - customMethods
- (void)initMethod
{
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"关于我们"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setFrame:CGRectMake(0, 0, 100, 40)];
    [label setFont:[UIFont systemFontOfSize:18 weight:20]];
    self.navigationItem.titleView = label;
    
    //tablebar背景色
    [self.navigationController.navigationBar setBarTintColor:LQSColor(21, 194, 251, 1)];
    [self.tabBarController.tabBar setHidden:YES];
    
    [self addContentView];
    
    //
    array = [[NSMutableArray alloc] init];
    LQSAboutUsModel * model1 = [[LQSAboutUsModel alloc] init];
    model1.title = @"应用介绍";
    model1.url = @"北京龙泉寺官方论坛";
    
    LQSAboutUsModel * model2 = [[LQSAboutUsModel alloc] init];
    model2.title = @"反馈邮箱";
    model2.url = @"longquanluntan@163.com";
    
    LQSAboutUsModel * model3 = [[LQSAboutUsModel alloc] init];
    model3.title = @"官方网站";
    model3.url = @"http://forum.longquanzs.org/";
    
    LQSAboutUsModel * model4 = [[LQSAboutUsModel alloc] init];
    model4.title = @"腾讯微博";
    model4.url = @"http://t.qq.com/xuechengfashi";
    
    LQSAboutUsModel * model5 = [[LQSAboutUsModel alloc] init];
    model5.title = @"新浪微博";
    model5.url = @"http://weibo.com/xuecheng";
    
    [array addObject:model1];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model5];
    
}
- (void)addContentView
{
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    listView = [[UITableView alloc]init];
    [listView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    listView.dataSource = self;
    listView.delegate = self;
    [self.view addSubview:listView];
    [listView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


#pragma listView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.section];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellStyleValue1;
    }
    LQSAboutUsModel * model = array[indexPath.row];
    [cell.textLabel setText:model.title];
    [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    [cell.detailTextLabel setText:model.url];
    [cell.detailTextLabel setTextColor:LQSColor(21, 194, 251, 1)];
   
 
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#pragma - mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQSAboutUsModel * model = array[indexPath.row];
    if ([model.title isEqualToString:@"反馈邮箱"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://admin@hzlzh.com"]];
        
    }else if (![model.title isEqualToString:@"龙泉寺官方论坛"]) {
        LQSWebVC * webVC = [[LQSWebVC alloc] init];
        webVC.urlString = model.url;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }

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
