//
//  LQSVideoViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSCishanViewController.h"

@interface LQSCishanViewController ()<UITableViewDelegate,UITableViewDataSource>
//帖子数组
@property (nonatomic, strong) NSMutableArray *cishanStatusFrameArr;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic,strong) NSMutableArray *cishanArr;

@end

@implementation LQSCishanViewController

- (NSMutableArray *)cishanStatusFrameArr
{
    if (!_cishanStatusFrameArr) {
        self.cishanStatusFrameArr = [NSMutableArray array];
        
    }
    return _cishanStatusFrameArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.page = 1;
    [self reloadCishanDateRequestWithPage:self.page];
    [self.cishanStatusFrameArr addObjectsFromArray:self.cishanArr];
    [self createTableView];
    [self.tableView reloadData];
}


- (void)createTableView{
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 3.设置tableView属性
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 添加底部的额外区域(为tableView扩充底部的内容)
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);


}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    添加刷新控件
    [self setupRefresh];

    [self.tableView.mj_header beginRefreshing];

}

- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    [self.tableView.mj_header beginRefreshing];
    
    // 2.添加上拉刷新控件
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    
    
   
    


}
/**
 *  加载最新的微博数据
 */
- (void)loadNewStatus
{
    self.page = 1;
    [self reloadCishanDateRequestWithPage:self.page];
    [self.cishanStatusFrameArr insertObjects:self.cishanArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.cishanArr.count)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新瀑布流控件
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.mj_header endRefreshing];
    });

}

/**
 *  加载更多的微博数据(时间比较早的)
 */
- (void)loadMoreStatus
{
    self.page++;
    [self reloadCishanDateRequestWithPage:self.page];
    [self.cishanStatusFrameArr addObjectsFromArray:self.cishanArr];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新瀑布流控件
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.mj_footer endRefreshing];
    });

}


- (void)reloadCishanDateRequestWithPage:(NSUInteger)page
{
    if ([[NSString stringWithFormat:@"%lud",self.page] isEqualToString:@"1"] && self.cishanArr) {
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
    paramDic[@"page"] = [NSString stringWithFormat:@"%lud",self.page];
    paramDic[@"accessSecret"] = @"cd090971f3f83391cd4ddc034638c";
    paramDic[@"circle"] = @"0";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
//        数据模型放到frame模型
        
        
        
        
        
        
        
        if (self.cishanArr.count > 0) {
            [self.cishanArr removeAllObjects];
        }else{
            
            NSMutableArray *cishanArr = [[NSMutableArray alloc] init];
            self.cishanArr = cishanArr;
        }
        self.cishanArr = [LQSCishanListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        
        NSMutableArray *newFrames = [NSMutableArray array];

        for (LQSCishanListModel * cishanModel in self.cishanArr) {
            LQSCishanModelFrame *frame = [[LQSCishanModelFrame alloc] init];
            frame.cishanStatus = cishanModel;
            [newFrames addObject:frame];
        }
        
        [self.cishanStatusFrameArr addObjectsFromArray:newFrames];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        
    }];
    
}



#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cishanStatusFrameArr.count;
}

#pragma mark 每一行显示怎样的cell（内容）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQScishanViewCell *cell = [LQScishanViewCell cellWithTableView:tableView];
    
    cell.statusFrame = self.cishanStatusFrameArr[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tabBarItem.badgeValue = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQSCishanModelFrame *frame = self.cishanStatusFrameArr[indexPath.row];
    return frame.cellHeight;
//    return 30;
}


@end
