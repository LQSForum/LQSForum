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

@interface LQSLeftTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *leftDataArray;
@property (nonatomic, strong) NSMutableArray *sectionDataArray;
@property (nonatomic, strong) NSMutableArray *focusData;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic, assign) NSInteger index;

@end

@implementation LQSLeftTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc] init];
    }
    
    [self loadServerData];
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
    
    NSString *urlStringOthers = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/forumlist";
    NSDictionary *parametersOthers = @{@"accessSecret":@"cd090971f3f83391cd4ddc034638c",
                                       @"accessToken":@"f9514b902a334d6c0b23305abd46d",
                                       @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                       @"sdkVersion":@"2.4.0",
                                       @"apphash":@"f0d7f05f"};
    [self loadServerDataWithUrlString:urlStringOthers parameters:parametersOthers];

    NSString *urlStringFocus = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/forumlist";
    NSDictionary *parametersFocus = @{@"accessSecret":@"4aab1523559aeef6bdc16d9a07d93",
                                 @"accessToken":@"5769ef37c713ca23b8d1816c2133c",
                                 @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                 @"sdkVersion":@"2.4.3.0",
                                 @"apphash":@"5038dae8",
                                 @"type":@"rec"};
    [self loadFocusDataWithUrlString:urlStringFocus parameters:parametersFocus];
    
    
    
}

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
        dispatch_async(dispatch_get_main_queue(), ^{
            [self  reloadData];
            
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    //    LQSSectionModel *model = self.leftDataArray[indexPath.row];
    cell.backgroundColor = LQSColor(235, 235, 235, 1.0);
    cell.textLabel.text = self.leftDataArray[indexPath.row];
    cell.layer.borderColor = LQSColor(233, 231, 233, 1.0).CGColor;
    cell.layer.borderWidth = 0.25;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = selectedBackgroundView;
    
    if ([self.leftViewDelegate respondsToSelector:@selector(leftTableView:rightViewArray:allDataArray:)]) {
        if (indexPath.row == 0) {
            NSMutableArray *rightViewDataArray = self.focusData;
            [self.leftViewDelegate leftTableView:self rightViewFocusArray:rightViewDataArray allDataArray:self.allDataArray];
        }else{
            LQSSectionModel *sectionModel = self.sectionDataArray[indexPath.row - 1];
            //        NSLog(@"%@",sectionModel);
            NSMutableArray *rightViewDataArray = sectionModel.items;
            [self.leftViewDelegate leftTableView:self rightViewArray:rightViewDataArray allDataArray:self.allDataArray];
        }
    }
    
}


- (NSMutableArray *)leftDataArray{
    
    if (_leftDataArray == nil) {
        _leftDataArray = [NSMutableArray arrayWithObjects:@"我的关注",@"原创天地",@"学修家园",@"特色龙泉",@"论坛实务", nil];
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
