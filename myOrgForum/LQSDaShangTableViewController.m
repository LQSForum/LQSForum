//
//  LQSDaShangTableViewController.m
//  myOrgForum
//
//  Created by Queen_B on 2016/11/13.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSDaShangTableViewController.h"
// sec1的sectionHeaderView
#import "LQSdashangSecView.h"
// 打赏的cell
#import "LQSDashangTableViewCell.h"
#define kNAVITITLE @"打赏"
@interface LQSDaShangTableViewController ()

@end

@implementation LQSDaShangTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kNAVITITLE;
    self.navigationItem.rightBarButtonItem = nil;
    [self setupTableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)setupTableView{
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LQSScreenW, LQSScreenH) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
-(LQSdashangSecView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LQSdashangSecView *headerView;
    if (section == 0) {
        headerView = [[LQSdashangSecView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        headerView.headerOrFooter = header;
        [headerView setupViews];
    }
    return headerView;
}
-(LQSdashangSecView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LQSdashangSecView *footerView;
    if (section == 2) {
        footerView = [[LQSdashangSecView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        footerView.headerOrFooter = footer;
        [footerView setupViews];
        footerView.sureBtnclkBlock = ^(UIButton *btn){
            NSLog(@"viewForFooterInSection.btnClick");
        };
    }
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        LQSDashangTableViewCell *weixiaoCell = [tableView dequeueReusableCellWithIdentifier:@"weixiaoCell"];
        if (!weixiaoCell) {
            weixiaoCell = [[LQSDashangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"weixiaoCell"];
        }
        weixiaoCell.indexPath = indexPath;
        return weixiaoCell;
    }else if (indexPath.section == 1){
        LQSDashangTableViewCell *pingfenCell = [tableView dequeueReusableCellWithIdentifier:@"pingfenCell"];
        if (!pingfenCell) {
            pingfenCell = [[LQSDashangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pingfenCell"];
        }
        pingfenCell.indexPath = indexPath;
        return pingfenCell;
    }
    else if (indexPath.section == 2){
        LQSDashangTableViewCell *tongZhiZuoZheCell = [tableView dequeueReusableCellWithIdentifier:@"tongZhiCell"];
        if (!tongZhiZuoZheCell) {
            tongZhiZuoZheCell = [[LQSDashangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tongZhiCell"];
        }
        tongZhiZuoZheCell.indexPath = indexPath;
        return tongZhiZuoZheCell;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }
    else {return 20;}
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2){
        return 56;
    }
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:{
            height = 50;
            break;
        }case 1:{
            return 115;
            break;
        }case 2:{
            height = 40;
            break;
        }
        default:
            break;
    }
    return height;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
