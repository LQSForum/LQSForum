//
//  LQSLeftTableView.m
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSLeftTableView.h"
#import "AFNetworking.h"
#import "LQSSectionModel.h"
#import "LQSCellModel.h"
#import "YYModel.h"
#import "LQSLeftViewCell.h"

@interface LQSLeftTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *leftDataArray;//左侧页面数据
@property (nonatomic, strong) NSMutableArray *sectionDataArray;
@property (nonatomic, strong) NSMutableArray *focusData;//添加关注之后的数据
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *allDataArray;//所有数据
@property (nonatomic, assign) NSInteger index;//模型索引
@property (nonatomic, strong) NSString *selectedTitle;

@end

@implementation LQSLeftTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc] init];
        self.selectedTitle = self.leftDataArray[0];
    }
    
        //请求论坛版块所有数据
        [self loadServerData];
    
//    [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
//    [self tableView:self didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
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


//请求论坛版块所有数据
- (void)loadServerData{
    
    NSString *urlStringOthers = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/forumlist";
    NSDictionary *parametersOthers = @{@"accessSecret":@"cd090971f3f83391cd4ddc034638c",
                                       @"accessToken":@"f9514b902a334d6c0b23305abd46d",
                                       @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                       @"sdkVersion":@"2.4.0",
                                       @"apphash":@"f0d7f05f"};
    [self loadServerDataWithUrlString:urlStringOthers parameters:parametersOthers];
    
    
  
    
    
}


//请求我的关注的猜你喜欢数据
- (void)loadFocusData{
    NSString *urlStringFocus = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/forumlist";
    NSDictionary *parametersFocus = @{@"accessSecret":@"4aab1523559aeef6bdc16d9a07d93",
                                      @"accessToken":@"5769ef37c713ca23b8d1816c2133c",
                                      @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                      @"sdkVersion":@"2.4.3.0",
                                      @"apphash":@"5038dae8",
                                      @"type":@"rec"};
    //    [NSThread sleepForTimeInterval:1.0];
    [self loadFocusDataWithUrlString:urlStringFocus parameters:parametersFocus];

}

//请求我的关注的猜你喜欢数据
- (void)loadFocusDataWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters{
    
    [self.sessionManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        //        NSString *p = @"/Users/yuhan/Desktop/plist";
        //        NSString *path = [p stringByAppendingPathComponent:@"forum.plist"];
        //        [dict writeToFile:path atomically:YES];
        LQSLog(@"%@",dict);
        
        NSArray *listArr = dict[@"recommendedBoard"];
        for (NSDictionary *itemDict in listArr) {
            LQSCellModel *cellModel = [LQSCellModel yy_modelWithDictionary:itemDict];
            [self.allDataArray enumerateObjectsUsingBlock:^(LQSCellModel *cellModel1, NSUInteger idx, BOOL * _Nonnull stop) {
                if (cellModel1.board_id == cellModel.board_id) {
                    cellModel.ID = cellModel1.ID;
                }
            }];

            [self.focusData addObject:cellModel];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self  reloadData];
            //数据传递给mainView用于启动页面时自动选中左侧第一行所对应的右侧视图数据
            [[NSNotificationCenter defaultCenter]postNotificationName:@"focus" object:self.focusData];
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [self.mj_header endRefreshing];
        NSLog(@"error%@",error);
        
    }];
    
    
}

- (void)loadServerDataWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters{

    [self.sessionManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        //        NSString *p = @"/Users/yuhan/Desktop/plist";
        //        NSString *path = [p stringByAppendingPathComponent:@"forum.plist"];
        //        [dict writeToFile:path atomically:YES];
        //        LQSLog(@"%@",dict);
        
        NSArray *listArr = dict[@"list"];
        self.index = 1;
        for (NSDictionary *sectionDict in listArr) {
            NSString *sectionName = sectionDict[@"board_category_name"];
            [self.leftDataArray addObject:sectionName];
            LQSSectionModel *model = [LQSSectionModel yy_modelWithDictionary:sectionDict];
            [self.sectionDataArray addObject:model];
            NSArray *cellListArr = sectionDict[@"board_list"];
            for (NSDictionary *itemDict in cellListArr) {
                LQSCellModel *cellModel = [LQSCellModel yy_modelWithDictionary:itemDict];
                cellModel.ID = self.index;
                self.index++;
                [model.items addObject:cellModel];
                [self.allDataArray addObject:cellModel];
            }
            
            
        }
         [self loadFocusData];; //请求B
        dispatch_async(dispatch_get_main_queue(), ^{
            [self  reloadData];
            //数据传递给mainView用于启动页面时自动选中左侧第一行所对应的右侧视图数据
            [[NSNotificationCenter defaultCenter] postNotificationName:@"allData" object:self.allDataArray];
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [self.mj_header endRefreshing];
        NSLog(@"error%@",error);
        
    }];
  
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leftDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"LQSPartTableViewCellID";
    LQSLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LQSLeftViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    cell.title = self.leftDataArray[indexPath.row];
    if ([self.selectedTitle isEqualToString:self.leftDataArray[indexPath.row]]) {
        cell.isSelected = YES;
    } else {
        cell.isSelected = NO;
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedTitle = self.leftDataArray[indexPath.row];

    if (indexPath.row == 0) {
        NSMutableArray *rightViewDataArray = self.focusData;
        if ([self.leftViewDelegate respondsToSelector:@selector(leftTableView:rightViewFocusArray:allDataArray:)]) {
            [self.leftViewDelegate leftTableView:self rightViewFocusArray:rightViewDataArray allDataArray:self.allDataArray];
        }
        
    }else{
            LQSSectionModel *sectionModel = self.sectionDataArray[indexPath.row - 1];
            //        NSLog(@"%@",sectionModel);
            NSMutableArray *rightViewDataArray = sectionModel.items;
        if ([self.leftViewDelegate respondsToSelector:@selector(leftTableView:rightViewArray:allDataArray:)] ){
            [self.leftViewDelegate leftTableView:self rightViewArray:rightViewDataArray allDataArray:self.allDataArray];
        }
    }
     [tableView reloadData];
}


- (NSMutableArray *)leftDataArray{
    
    if (_leftDataArray == nil) {
        _leftDataArray = [NSMutableArray arrayWithObjects:@"我的关注", nil];
    }
    
    return _leftDataArray;
}

- (NSMutableArray *)sectionDataArray{
    if (_sectionDataArray == nil) {
        _sectionDataArray = [NSMutableArray array];
    }
    return _sectionDataArray;
}

- (NSMutableArray *)focusData{
    
    if (_focusData == nil) {
        _focusData = [NSMutableArray array];
    }
    return _focusData;
}

- (NSMutableArray *)allDataArray{
    if (_allDataArray == nil) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}


@end
