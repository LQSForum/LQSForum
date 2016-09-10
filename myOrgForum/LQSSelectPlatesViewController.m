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
    LQSSelectPlatesDataModel *_selectPlatesModel;
    
    
    
}

@property (nonatomic, strong) NSMutableArray *banKuaiArr;//板块
@property (nonatomic, strong) NSMutableArray *banKuaiArray;//内容
@property (nonatomic, strong) NSMutableArray *sectionNameArray;//板块名字数组
@property (nonatomic, strong) NSMutableArray *cellNameArray;//每个cell名字数组
@property (nonatomic, strong) NSMutableArray *sectionCountArr;
@property (nonatomic, strong) NSMutableArray *markSectionCoutArray;



@end

@implementation LQSSelectPlatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    初始化数据
    self.banKuaiArr = [NSMutableArray array];
    self.banKuaiArray = [NSMutableArray array];
    self.sectionNameArray = [NSMutableArray array];
    self.cellNameArray = [NSMutableArray array];
    self.sectionCountArr = [NSMutableArray array];
    self.markSectionCoutArray = [NSMutableArray array];
    
    self.title = @"选择板块";
//    返回
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    
    //   创建tableview
    [self createTableView];
    [self reloadData];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark - Data
- (void)reloadData{

    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"forum/forumlist";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    paramDic[@"egnVersion"] = @"v2035.2";
    paramDic[@"accessToken"] = @"83e1f2e3b07cc0629ac89ed355920";
    paramDic[@"apphash"] = @"6499b617";

    paramDic[@"sdkVersion"] = @"2.4.3.0";
    paramDic[@"accessSecret"] = @"f2f5082208b27a9ed946842b8a686";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        weakSelf.banKuaiArr = [LQSSelectPlatesDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        获取板块的名称
//        NSUInteger i = 0;//标记有几组数据
        for (LQSSelectPlatesDataModel *model in weakSelf.banKuaiArr) {
            [self.sectionNameArray addObject:model.board_category_name];
            weakSelf.banKuaiArray = [LQSSelectPlatesDetailDataModel mj_objectArrayWithKeyValuesArray:model.board_list];
//            存放cell的名称
            for (LQSSelectPlatesDetailDataModel *detailModel in weakSelf.banKuaiArray) {
                [_cellNameArray addObject:detailModel.board_name];
                
            }
            
        }
                [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        kNetworkNotReachedMessage;
    }];

}




#pragma mark tableViewDelegate&dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.banKuaiArr.count;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//获取足模型
    LQSSelectPlatesDataModel *model = self.banKuaiArr[section];
    return model.board_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"selectPlatesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//        拿到组模型
        LQSSelectPlatesDataModel *section = self.banKuaiArr[indexPath.section];
        LQSSelectPlatesDetailDataModel *detailModel = [LQSSelectPlatesDetailDataModel mj_objectWithKeyValues:section.board_list[indexPath.row]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        label.text = detailModel.board_name;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        
        
    }
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
//        传值给compose的titleView
        LQSComposeViewController *composeVc = [LQSComposeViewController new];
        
        UITableViewCell *Cell = (UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        LQSSelectPlatesDataModel *section = self.banKuaiArr[indexPath.section];
        LQSSelectPlatesDetailDataModel *detailModel = [LQSSelectPlatesDetailDataModel mj_objectWithKeyValues:section.board_list[indexPath.row]];
        
//通知给上个页面传值
        
         [[NSNotificationCenter defaultCenter] postNotificationName:@"board_name" object:detailModel.board_name];
        
        
    }];



}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [self.sectionNameArray objectAtIndex:section];


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
@end
