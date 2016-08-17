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
        
    }
    
    //    NSDictionary *sortby = @{@"sortby":@"new"};
    //    [self loadServerDataWithSortby:self.sortby];
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
    
    LQSLastestMarrowModel *model = self.arrm[indexPath.row];
    cell.model = model;
    
    return cell;
    
    
}

-(void)loadServerDataWithSortby:(NSDictionary *)sortby
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/topiclist"];
    
    
    [self.sessionManager POST:urlString parameters:sortby progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSString *p = @"/Users/a/Documents/LQS/plist";
        NSString *path = [p stringByAppendingPathComponent:@"new.plist"];
        [dict writeToFile:path atomically:YES];
//        NSLog(@"%@",dict);
        
        NSArray *listArr = dict[@"list"];
        for (NSDictionary *dict in listArr) {
            LQSLastestMarrowModel *model = [LQSLastestMarrowModel yy_modelWithDictionary:dict];
            [self.arrm addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self  reloadData];
            
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [self.mj_header endRefreshing];
        NSLog(@"error%@",error);
        
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

- (void)setSortby:(NSDictionary *)sortby{
    _sortby = sortby;
    [self.arrm removeAllObjects];
    //    [self reloadData];
//    NSDictionary *parameters = @{}
    [self loadServerDataWithSortby:sortby];
}

@end

