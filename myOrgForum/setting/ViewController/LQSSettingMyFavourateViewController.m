//
//  LQSSettingMyFavourateViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSettingMyFavourateViewController.h"
#import "LQSUserManager.h"
@interface LQSSettingMyFavourateViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
    
    
}
//帖子数组
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic,strong) NSMutableArray *shouchangArr;
@property (nonatomic,strong) NSMutableArray *shouchangArray;


@end

@implementation LQSSettingMyFavourateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    // Do any additional setup after loading the view.

    self.shouchangArr = [NSMutableArray array];
    self.shouchangArray = [NSMutableArray array];
    [self createTableView];
    self.page = 1;
    [self reloadShouchangDateRequestWithPage:self.page];
    //
    _tableView.mj_footer.hidden = YES;




}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupRefresh];
    [_tableView.mj_header beginRefreshing];
}

- (void)reloadShouchangDateRequestWithPage:(NSUInteger)page{

    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"user/topiclist";
    paramDic[@"pageSize"] = @"20";
    paramDic[@"uid"] = [LQSUserManager user].uid;
    paramDic[@"egnVersion"] = @"v2035.2";
    paramDic[@"type"] = @"favorite";
    paramDic[@"sdkVersion"] = @"2.4.3.0";
    paramDic[@"apphash"] = @"6499b617";
    paramDic[@"isImageList"] = @"1";
    paramDic[@"accessToken"] = @"83e1f2e3b07cc0629ac89ed355920";
    paramDic[@"page"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.page];
    paramDic[@"accessSecret"] = @"f2f5082208b27a9ed946842b8a686";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"favirate-----sucess");
        //        数据模型放到frame模型
        if (weakSelf.shouchangArray.count > 0 && self.page == 1) {
            [weakSelf.shouchangArr removeAllObjects];
        }else{
            weakSelf.shouchangArr = [LQSCishanListModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        }
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"favirate------failure");
        [_tableView.mj_header endRefreshing];
        kNetworkNotReachedMessage;
    }];
    



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
    [self reloadShouchangDateRequestWithPage:self.page];
    [self.shouchangArray insertObjects:self.shouchangArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.shouchangArr.count)]];
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
    [self reloadShouchangDateRequestWithPage:self.page];
    [self.shouchangArray addObjectsFromArray:self.shouchangArr];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新瀑布流控件
        [_tableView reloadData];
        // 停止刷新
        [_tableView.mj_footer endRefreshing];
    });
    
}





- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  0 , kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 3.设置tableView属性
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.mj_footer.hidden = self.shouchangArray.count == 0;
    
    return self.shouchangArray.count;
}

#pragma mark 每一行显示怎样的cell（内容）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ciShanCell";
    LQSCishanTableViewCell *cishanCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cishanCell == nil) {
        cishanCell = [[LQSCishanTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    
    [cishanCell pushesCishanDataModel:[self.shouchangArray objectAtIndex:indexPath.row]];
    return cishanCell;
    
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQSBBSDetailViewController *DetailVc = [LQSBBSDetailViewController new];
    DetailVc.selectModel = [self.shouchangArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:DetailVc animated:NO];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LQSCishanTableViewCell *cishanCell = (LQSCishanTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cishanCell.cellHeight;
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
    
}
@end
