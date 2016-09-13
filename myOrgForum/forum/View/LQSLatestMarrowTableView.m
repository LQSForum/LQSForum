//
//  LQSLatestMarrowTableView.m
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSLatestMarrowTableView.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "LQSLastestMarrowModel.h"
#import "LQSLatestMarrowTableViewCell.h"
@interface LQSLatestMarrowTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *arrm;
@property (nonatomic, strong) NSMutableArray *arrmMore;
@property (nonatomic, assign) NSInteger pageNum;
@end

@implementation LQSLatestMarrowTableView

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        //        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        //        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSSet *set = [NSSet setWithObjects:@"text/plain", @"text/html", nil];
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
    }
    return _sessionManager;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        [self setupRefresh];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return self.arrm.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"LQSLatestMarrowTableViewCellID";
    LQSLatestMarrowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LQSLatestMarrowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.row == self.arrm.count - 1) {
        self.pageNum ++;
        [self loadServerDataWithSortby:self.sortby pageNum:self.pageNum];
    }
    LQSLastestMarrowModel *model = self.arrm[indexPath.row];
    cell.model = model;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LQSBBSDetailViewController *detailVc = [LQSBBSDetailViewController new];
    LQSLastestMarrowModel *model = self.arrm[indexPath.row];
    detailVc.selectModel.board_id = [NSString stringWithFormat:@"%zd",model.board_id];
    detailVc.selectModel.topicId = [NSString stringWithFormat:@"%zd",model.topic_id];
    if ([self.idelegate respondsToSelector:@selector(latestMarrowTableView:detailVc:)]) {
        [self.idelegate latestMarrowTableView:self detailVc:detailVc];
    }
    
    
}


- (void)setupRefresh {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadServerDataWithSortby:pageNum:)];
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadServerDataWithSortby:pageNum:)];

}


-(void)loadServerDataWithSortby:(NSString *)sortby pageNum:(NSInteger)pageNum
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/topiclist"];
    NSDictionary *dict = @{@"sortby":sortby,@"pageSize":@20,@"page":@(self.pageNum)};
    
    [self.sessionManager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//        NSString *p = @"/Users/a/Documents/LQS/plist";
//        NSString *path = [p stringByAppendingPathComponent:@"new.plist"];
//        [dict writeToFile:path atomically:YES];
//        NSLog(@"%@",dict);
        
        NSArray *listArr = dict[@"list"];
        for (NSDictionary *dict in listArr) {
            LQSLastestMarrowModel *model = [LQSLastestMarrowModel yy_modelWithDictionary:dict];
            [self.arrm addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self  reloadData];
            [self.mj_header endRefreshing];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.mj_header endRefreshing];
            LQSLog(@"error%@",error);
            kNetworkNotReachedMessage;
    }];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}



- (NSMutableArray *)arrm{
    
    if (_arrm == nil) {
        _arrm = [NSMutableArray array];
    }
    return _arrm;
}

- (NSMutableArray *)arrmMore{
    
    if (_arrmMore == nil) {
        _arrmMore = [NSMutableArray array];
    }
    return _arrmMore;
}

- (void)setSortby:(NSString *)sortby{
    _sortby = sortby;
    [self.arrm removeAllObjects];
        [self reloadData];
    self.pageNum = 1;
    [self loadServerDataWithSortby:sortby pageNum:self.pageNum];
    
}

@end

