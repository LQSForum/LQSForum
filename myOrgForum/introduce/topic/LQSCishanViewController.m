//
//  LQSVideoViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSCishanViewController.h"

@interface LQSCishanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    LQSUITableView *_tableView;



}
//帖子数组
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic,strong) NSMutableArray *cishanArr;
@property (nonatomic,strong) NSMutableArray *cishanArray;

@property (nonatomic,strong) NSMutableArray *imageArr;

@end

@implementation LQSCishanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = [UIColor cyanColor];
    [self reloadCishanDateRequestWithPage:self.page];
    [self createTableView];
    //    添加刷新控件
    [_tableView setRefresh];

    
}


- (void)createTableView{
    _tableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, 64 + 5.5 , kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 3.设置tableView属性
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];

}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)reloadCishanDateRequestWithPage:(NSUInteger)page
{
    if ([[NSString stringWithFormat:@"%lud",(unsigned long)self.page] isEqualToString:@"1"] && self.cishanArr) {
        [self.cishanArr removeAllObjects];
    }

    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"portal/newslist";
    paramDic[@"sdkVersion"] = @"2.4.0";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    paramDic[@"pageSize"] = @"20";
    paramDic[@"longitude"] = @"116.300859";
    paramDic[@"moduleId"] = @"2";
    paramDic[@"latitude"] = @"39.981122";
    paramDic[@"accessToken"] = @"f9514b902a334d6c0b23305abd46d";
    paramDic[@"page"] = [NSString stringWithFormat:@"%lud",(unsigned long)self.page];
    paramDic[@"accessSecret"] = @"cd090971f3f83391cd4ddc034638c";
    paramDic[@"circle"] = @"0";
    paramDic[@"isImageList"] = @"1";
    paramDic[@"egnVersion"] = @"v2035.2";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
//        数据模型放到frame模型
              if (weakSelf.cishanArr.count > 0 && weakSelf.page == 1) {
            [weakSelf.cishanArr removeAllObjects];
        }else{
            
            NSMutableArray *cishanArr = [[NSMutableArray alloc] init];
            weakSelf.cishanArr = cishanArr;
        }
        weakSelf.cishanArr = [LQSCishanListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        weakSelf.cishanArray = [NSMutableArray array];
        [weakSelf.cishanArray addObjectsFromArray:self.cishanArr];
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        [_tableView.mj_header endRefreshing];
        kNetworkNotReachedMessage;
    }];
    
}



#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cishanArray.count;
}

#pragma mark 每一行显示怎样的cell（内容）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ciShanCell";
    LQSCishanTableViewCell *cishanCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cishanCell == nil) {
        cishanCell = [[LQSCishanTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    
    [cishanCell pushesCishanDataModel:[self.cishanArray objectAtIndex:indexPath.row]];
    return cishanCell;
    
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tabBarItem.badgeValue = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    LQSCishanTableViewCell *cishanCell = (LQSCishanTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cishanCell.cellHeight;
    
    
    
    
    
    
}


@end
