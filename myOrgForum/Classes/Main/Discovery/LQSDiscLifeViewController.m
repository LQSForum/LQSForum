//
//  LQSDiscLifeViewController.m
//  myOrgForum
//
//  Created by g x on 2017/7/18.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSDiscLifeViewController.h"
#import "LQSNewDiscoverCell.h"
#import "LQSDiscoverModel.h"
#import "LQSBBSDetailViewController.h"

@interface LQSDiscLifeViewController ()
//帖子数组
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableArray *tempStoreArr;


@end

@implementation LQSDiscLifeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupRefresh];
    //[self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer.hidden = YES;
    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self loadDateRequestWithPage:self.page];
}
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    
    // 2.添加上拉刷新控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    
}


- (void)loadNewStatus
{
    self.page = 1;
    [self loadDateRequestWithPage:self.page];
    [self.dataSource insertObjects:self.tempStoreArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tempStoreArr.count)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.mj_header endRefreshing];
    });
    
}

- (void)loadMoreStatus
{
    self.page++;
    [self loadDateRequestWithPage:self.page];
}

// 注：这个方法是用于暴漏给外部提前请求数据用的，因为如果等到视图加载时才请求网络数据，会导致数据延迟，视图加载稍慢。所以外部调用时，可以在视图加载前就把数据准备好。这样就比较平滑。
// 这类视图目前还没想到更好的解决办法。最开始是在外部的LQSNewDiscoverVC 里面，直接把子控制器，也就是下面4个栏（资料下载等）控制器的tableView添加到父控制器的视图上，然后控制它们的offset，但是在外部直接添加时，会有一个问题，就是外部已经要调用这里面的tableView了。但是tableView的数据还没请求，所以出现了这样的情况：tableView会先显示一次没数据的，然后数据请求完成后，会走reloadData的方法，再此刷新tableView，这就出现了卡跳的效果。
// 目前想到的解决办法是：子控制器对外暴露一个请求网络的block方法，父控制器在要加载子控制器的视图时，先调用这个方法让子控制器请求网络并初始化好存储熟组，然后在成功的block回调里面加载子试图的tableview，这时的tableView是已经有了数据源了。所以可以直接显示。
-(void)prepareNetDataForBorderId:(NSString *)boardId success:(void (^)())success failure:(void (^)())failure{
    self.page = 1 ;
    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/topiclistex";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"boardId"] = boardId;
    paramDic[@"page"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.page];
    paramDic[@"pageSize"] = @"20";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"downLoad--------sucess");
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
       // NSLog(@"%@",result);
        
        //  NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //      这里的tempStoreArr相当于缓存，从服务器拿到的数据缓存在这里，每次上拉加载新数据时，清空缓存，存新的数据，然后tableView.dataSource是dataSource.
        // 0.清空缓存
        [self.tempStoreArr removeAllObjects];
        // 1.每次都从服务器拿新数据
        weakSelf.tempStoreArr = [LQSDiscoverListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        // 2.如果现在是第一页，则清空dataSource,并从缓存拿数据；如果不是第一页，直接加上缓存的数据
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:self.tempStoreArr];
        success();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"cishan---------failure,%@",error);
        [self.tableView.mj_header endRefreshing];
        kNetworkNotReachedMessage;
    }];
    
    
}
// 网络请求
- (void)loadDateRequestWithPage:(NSUInteger)page{
    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/topiclistex";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"boardId"] = @(512);
    paramDic[@"page"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.page];
    paramDic[@"pageSize"] = @"20";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"downLoad--------sucess");
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",result);
        
        //  NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dict:%@",dict);
        //      这里的tempStoreArr相当于缓存，从服务器拿到的数据缓存在这里，每次上拉加载新数据时，清空缓存，存新的数据，然后tableView.dataSource是dataSource.
        // 0.清空缓存
        [self.tempStoreArr removeAllObjects];
        // 1.每次都从服务器拿新数据
        weakSelf.tempStoreArr = [LQSDiscoverListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        // 2.如果现在是第一页，则清空dataSource,并从缓存拿数据；如果不是第一页，直接加上缓存的数据
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:self.tempStoreArr];
        if (self.page == 1) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"cishan---------failure,%@",error);
        [self.tableView.mj_header endRefreshing];
        kNetworkNotReachedMessage;
    }];
    
    
}

- (void)setupViews{
    self.page = 1;
    static CGFloat fourBtnHeight = 35;// 按钮高度30+顶部间距5
    
    CGFloat headerHeight = kScreenWidth/2+fourBtnHeight;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)];
    self.tableView.tableHeaderView.backgroundColor = [UIColor redColor];
    //self.tableView.bounces = NO;
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.mj_footer.hidden = self.tempStoreArr.count == 0;
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LQSDiscoverListModel *model = self.dataSource[indexPath.row];
    CGFloat cellHeight = model.cellheight;
    return cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LQSDiscoverListModel *model = self.dataSource[indexPath.row];
    LQSBBSDetailViewController *detailVC = [[LQSBBSDetailViewController alloc]init];
    detailVC.topicID = [NSString stringWithFormat:@"%zd",model.topic_id];
    detailVC.boardID = [NSString stringWithFormat:@"%zd",model.board_id];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LQSNewDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadCell"];
    if (!cell) {
        cell = [[LQSNewDiscoverCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"downloadCell"];
    }
    LQSDiscoverListModel *model = self.dataSource[indexPath.row];
    [cell setCellWithModel:model];
    
    return cell;
}
#pragma mark - 懒加载
-(NSMutableArray *)tempStoreArr{
    if (!_tempStoreArr) {
        _tempStoreArr = [NSMutableArray array];
    }
    return _tempStoreArr;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



@end
