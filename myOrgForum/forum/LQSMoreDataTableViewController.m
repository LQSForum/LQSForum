//
//  LQSMoreDataTableViewController.m
//  myOrgForum
//
//  Created by a on 16/9/7.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSMoreDataTableViewController.h"
#import "LQSMoreDataTableViewCell.h"
#import "LQSForumDetailForumInfoModel.h"
@interface LQSMoreDataTableViewController ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *moreDataArray;
@end

@implementation LQSMoreDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        self.tableView.backgroundColor = LQSColor(250, 248, 251, 1.0);
    [self setupRefresh];
}

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

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                      refreshingAction:@selector(loadServerDataWithBoardId:)];
}


//请求论坛版块所有数据
- (void)loadServerDataWithBoardId:(NSInteger)boardId{
    
    NSString *urlString = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/topiclist";
    NSDictionary *parameters = @{@"topOrder":@"1",
                                 @"sdkVersion":@"2.4.3.0",
                                 @"apphash":@"7b0216df",
                                 @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                 @"pageSize":@"20",
                                 @"accessToken":@"5769ef37c713ca23b8d1816c2133c",
                                 @"sortby":@"top",
                                 @"page":@"1",
                                 @"isRatio":@"0",
                                 @"isImageList":@"1",
                                 @"accessSecret":@"4aab1523559aeef6bdc16d9a07d93",
                                 @"egnVersion":@"v2035.2",
                                 @"boardId":@(boardId),
                                 @"circle":@"0"
                                 };
    [self loadServerDataWithUrlString:urlString parameters:parameters];
    
    
    
    
    
}

- (void)loadServerDataWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters{
    
    //    __weak typeof(self) weakSelf = self;
    [self.sessionManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        for (NSDictionary *item in dict[@"list"]) {
            [self.moreDataArray addObject:[LQSForumDetailListModel yy_modelWithDictionary:item]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        LQSLog(@"error%@",error);
        kNetworkNotReachedMessage;
    }];
    
    
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.moreDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"moreDataCell";
    LQSMoreDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LQSMoreDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.model = self.moreDataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


- (NSMutableArray *)moreDataArray{
    if (_moreDataArray == nil) {
        _moreDataArray = [NSMutableArray array];
    }
    return _moreDataArray;
}


-(void)setBoardId:(NSInteger)boardId{
    _boardId = boardId;
    [self.moreDataArray removeAllObjects];
    [self.tableView reloadData];
//    self.pageNum = 1;
    [self loadServerDataWithBoardId:boardId];
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
