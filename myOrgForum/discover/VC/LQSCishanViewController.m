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
    UITableView *_tableView;



}
//帖子数组
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic,strong) NSMutableArray *cishanArr;
@property (nonatomic,strong) NSMutableArray *cishanArray;


@end

@implementation LQSCishanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.cishanArray = [NSMutableArray array];
    self.cishanArr = [NSMutableArray array];
    [self createTableView];
    self.page = 1;
    [self reloadCishanDateRequestWithPage:self.page];
//
    _tableView.mj_footer.hidden = YES;
}


- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 5.5 , kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 3.设置tableView属性
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];

}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupRefresh];
    [_tableView.mj_header beginRefreshing];
}


- (void)setupRefresh
{
    // 1.添加下拉刷新控件

    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];

    // 2.添加上拉刷新控件
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];

}
/**
 *  加载最新的数据
 */
- (void)loadNewStatus
{
    self.page = 1;
    [self reloadCishanDateRequestWithPage:self.page];
    [self.cishanArray insertObjects:self.cishanArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.cishanArr.count)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView reloadData];
        // 停止刷新
        [_tableView.mj_header endRefreshing];
    });

}
/**
 *  加载更多的微博数据(时间比较早的)
 */
- (void)loadMoreStatus
{
    self.page++;
    [self reloadCishanDateRequestWithPage:self.page];
    [self.cishanArray addObjectsFromArray:self.cishanArr];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新瀑布流控件
        [_tableView reloadData];
        // 停止刷新
        [_tableView.mj_footer endRefreshing];
    });
    
}
- (void)reloadCishanDateRequestWithPage:(NSUInteger)page
{

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
    paramDic[@"page"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.page];
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
              if (weakSelf.cishanArray.count > 0 && self.page == 1) {
            [weakSelf.cishanArr removeAllObjects];
        }else{
            weakSelf.cishanArr = [LQSCishanListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        }
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
    tableView.mj_footer.hidden = self.cishanArray.count == 0;

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
    LQSBBSDetailViewController *DetailVc = [LQSBBSDetailViewController new];
    DetailVc.selectModel = [_cishanArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:DetailVc animated:NO];


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    LQSCishanTableViewCell *cishanCell = (LQSCishanTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cishanCell.cellHeight;
    
    
    
    
    
    
}


@end
