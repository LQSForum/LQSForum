//
//  LQSRightTableView.m
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSRightTableView.h"
#import "AFNetworking.h"
#import "LQSSectionModel.h"
#import "LQSCellModel.h"
#import "YYModel.h"
#import "LQSRightViewCell.h"

@interface LQSRightTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *leftDataArray;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation LQSRightTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
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

- (void)loadServerData{
    
    NSString *urlString = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/forumlist";
    NSDictionary *parameters = @{@"accessSecret":@"cd090971f3f83391cd4ddc034638c",
                                 @"accessToken":@"f9514b902a334d6c0b23305abd46d",
                                 @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                 @"sdkVersion":@"2.4.0",
                                 @"apphash":@"f0d7f05f"};
    
    //    NSDictionary *attentionParameters =
    //    @{
    //      @"type":@"rec",
    //      @"forumKey":@"BW0L5ISVRsOTVLCTJx",
    //      @"accessSecret":@"4aab1523559aeef6bdc16d9a07d93",
    //      @"accessToken":@"5769ef37c713ca23b8d1816c2133c",
    //      @"egnVersion":@"v2035.2",
    //      @"sdkVersion":@"2.4.3.0",
    //      @"apphash":@"5038dae8"};
    
    /*
    [self.sessionManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        //        NSString *p = @"/Users/yuhan/Desktop/plist";
        //        NSString *path = [p stringByAppendingPathComponent:@"forum.plist"];
        //        [dict writeToFile:path atomically:YES];
        //        LQSLog(@"%@",dict);
        
        NSArray *listArr = dict[@"list"];
        for (NSDictionary *sectionDict in listArr) {
            LQSSectionModel *model = [LQSSectionModel yy_modelWithDictionary:sectionDict];
            [self.leftDataArray addObject:model];
            NSArray *cellListArr = sectionDict[@"board_list"];
            for (NSDictionary *itemDict in cellListArr) {
                LQSCellModel *cellModel = [LQSCellModel yy_modelWithDictionary:itemDict];
                [model.items addObject:cellModel];
                //                self.rightDataArray = model.items;
            }
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self  reloadData];
            
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [self.mj_header endRefreshing];
        NSLog(@"error%@",error);
        
    }];
    */
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.rightDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"LQSPartTableViewCellID";
    LQSRightViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LQSRightViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    LQSCellModel *cellModel = self.rightDataArray[indexPath.row];
    
    cell.cellModel = cellModel;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = selectedBackgroundView;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


- (void)setRightDataArray:(NSMutableArray *)rightDataArray{
    _rightDataArray = rightDataArray;
    [self reloadData];
}

@end
