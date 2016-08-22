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
    
    return 80;
}


- (void)setRightDataArray:(NSMutableArray *)rightDataArray{
    _rightDataArray = rightDataArray;
    [self reloadData];
}

@end
