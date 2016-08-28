//
//  LQSForumDetailViewController.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailViewController.h"
#import "LQSForumDetailForumInfoModel.h"
#import "LQSForumDetailHeadView.h"
#import "LQSForumDetailTopCell.h"
#import "LQSForumDetailCell.h"
#import "LQSForumDetailSectionHeadView.h"
#import "LQSCellModel.h"
@interface LQSForumDetailViewController ()<LQSForumDetailSectionDelegete>
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet LQSForumDetailHeadView *tableHeadView;

@property (nonatomic, readwrite, retain) LQSForumDetailSectionHeadView *sectionHeadView;
@property (nonatomic, readwrite, retain) NSMutableArray *topArray;
@property (nonatomic, readwrite, retain) NSMutableArray *mainArray;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, readwrite, assign) NSInteger sortBy;
@property (nonatomic, readwrite, retain) NSMutableArray *pageNum;
@end

@implementation LQSForumDetailViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    if ([self.mainTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.mainTableView setLayoutMargins:UIEdgeInsetsZero];
    }
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sortBy = 0;
    //初始化里面3个数组
    _mainArray = [NSMutableArray new];
    _topArray = [NSMutableArray new];
    _pageNum = [NSMutableArray new];
    for (int i=0; i<4; i++) {
        [_pageNum addObject:@"1"];
        [_mainArray addObject:[NSMutableArray new]];
    }
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadServerData)];
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadServerMoreData)];
    [self loadServerData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)loadChildForum{
    NSString *urlString = [NSString stringWithFormat:@"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/forumlist"];
    NSDictionary *dict = @{@"egnVersion":@"v2035.2",
                           @"sdkVersion":@"2.4.3.0",
                           @"apphash":@"2d2e362f",
                           @"fid":@(self.boardid),
                           @"accessToken":@"ee2cd39252cf3bb936f3d39520f0a",
                           @"accessSecret":@"eb8f8db2c2df69bec9be2e2eb1550",
                           @"forumKey":@"BW0L5ISVRsOTVLCTJx"};
    __weak typeof(self) weakSelf = self;
    [self.sessionManager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        for (NSDictionary *item in dict[@"list"][0][@"board_list"]) {
            [weakSelf.mainArray[3] addObject:[LQSCellModel yy_modelWithDictionary:item]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
            [self.mainTableView.mj_header endRefreshing];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.mainTableView.mj_header endRefreshing];
        LQSLog(@"error%@",error);
        kNetworkNotReachedMessage;
    }];
}
-(void)loadServerData{
    self.pageNum[self.sortBy] = @"1";
    [self.mainArray[self.sortBy] removeAllObjects];
    NSString *urlString = [NSString stringWithFormat:@"http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topiclist"];
    NSString* sortStr = @"all";
    switch (self.sortBy) {
        case 0:sortStr = @"all";break;
        case 1:sortStr = @"new";break;
        case 2:sortStr = @"marrow";break;
        default:break;
    }
    NSDictionary *dict = @{@"sortby":sortStr,
                           @"pageSize":@20,
                           @"page":self.pageNum[self.sortBy],
                           @"boardId":@(self.boardid),
                           @"apphash":@"1de934cc",
                           @"accessToken":@"7e3972a7a729e541ee373e7da3d06",
                           @"accessSecret":@"39a68e4d5473e75669bce2d70c4b9",
                           @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                           @"isRatio":@"1",
                           @"topOrder":@"1",
                           @"circle":@"0",
                           @"egnVersion":@"v2035.2",
                           @"sdkVersion":@"2.4.3.0"};
    __weak typeof(self) weakSelf = self;
    [self.sessionManager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        LQSForumDetailForumInfoModel* model = [LQSForumDetailForumInfoModel yy_modelWithDictionary:dict[@"forumInfo"]];
        weakSelf.tableHeadView.model = model;
        CGSize size = [weakSelf.tableHeadView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        weakSelf.tableHeadView.height = size.height;
        weakSelf.mainTableView.tableHeaderView = weakSelf.tableHeadView;
        [weakSelf.mainTableView reloadData];
        
        NSInteger num = [weakSelf.pageNum[weakSelf.sortBy] integerValue];
        weakSelf.pageNum[weakSelf.sortBy] = [NSString stringWithFormat:@"%zd",num+1];
        
        for (NSDictionary *item in dict[@"list"]) {
            [weakSelf.mainArray[self.sortBy] addObject:[LQSForumDetailListModel yy_modelWithDictionary:item]];
        }
        if ([dict[@"topTopicList"] count] > 0) {
            [weakSelf.topArray removeAllObjects];
            for (NSDictionary* item in dict[@"topTopicList"]) {
                [weakSelf.topArray addObject:[LQSForumDetailListModel yy_modelWithDictionary:item]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
            [self.mainTableView.mj_header endRefreshing];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.mainTableView.mj_header endRefreshing];
        LQSLog(@"error%@",error);
        kNetworkNotReachedMessage;
    }];
}
-(void)loadServerMoreData{
    NSString *urlString = [NSString stringWithFormat:@"http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topiclist"];
    NSString* sortStr = @"all";
    switch (self.sortBy) {
        case 0:sortStr = @"all";break;
        case 1:sortStr = @"new";break;
        case 2:sortStr = @"marrow";break;
        default:break;
    }
    NSDictionary *dict = @{@"sortby":sortStr,
                           @"pageSize":@20,
                           @"page":self.pageNum[self.sortBy],
                           @"boardId":@(self.boardid),
                           @"apphash":@"1de934cc",
                           @"accessToken":@"7e3972a7a729e541ee373e7da3d06",
                           @"accessSecret":@"39a68e4d5473e75669bce2d70c4b9",
                           @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                           @"isRatio":@"1",
                           @"topOrder":@"1",
                           @"circle":@"0",
                           @"egnVersion":@"v2035.2",
                           @"sdkVersion":@"2.4.3.0"};
    __weak typeof(self) weakSelf = self;
    [self.sessionManager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSInteger num = [weakSelf.pageNum[weakSelf.sortBy] integerValue];
        weakSelf.pageNum[weakSelf.sortBy] = [NSString stringWithFormat:@"%zd",num+1];
        for (NSDictionary *item in dict[@"list"]) {
            [weakSelf.mainArray[self.sortBy] addObject:[LQSForumDetailListModel yy_modelWithDictionary:item]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
            [self.mainTableView.mj_header endRefreshing];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.mainTableView.mj_header endRefreshing];
        LQSLog(@"error%@",error);
        kNetworkNotReachedMessage;
    }];
}
#pragma mark - LQSForumDetailSectionDelegete
- (void)selectTheType:(NSInteger)type{
    //NSLog(@"type = %zd",type);
    self.sortBy = type;
    if (type == 3) {
        [self loadChildForum];
    }
    else{
        if ([self.pageNum[self.sortBy] isEqualToString:@"1"]) {
            [self loadServerData];
        }
        else{
            [self.mainTableView reloadData];
        }
    }
}
#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.topArray.count != 0 && section == 0) {
        return [[UIView alloc] init];
    }
    if (_sectionHeadView == nil) {
        _sectionHeadView = [[NSBundle mainBundle] loadNibNamed:@"LQSForumDetailSectionHeadView" owner:nil options:nil][0];
        _sectionHeadView.delegate = self;
        if (self.boardChild == 0) {
            [_sectionHeadView removeSubForum];
        }
    }
    return _sectionHeadView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.topArray.count != 0 && section == 0) {
        return 0.01f;
    }
    return 45.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.topArray.count == 0) {
        return 1;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.topArray.count != 0 && section == 0) {
        return MIN(self.topArray.count, 4);
    }
    return [self.mainArray[self.sortBy] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.topArray.count != 0 && indexPath.section == 0) {
        if (indexPath.row < 3) {
            return 40;
        }
        return 30;
    }
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.sortBy == 3) {
        LQSCellModel *cellModel = self.mainArray[3];
        LQSForumDetailViewController* detailVC = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"ForumDetail"];
        detailVC.boardid = cellModel.board_id;
        detailVC.boardChild = cellModel.board_child;
        [self.navigationController pushViewController:detailVC animated:YES];
        return;
    }
    if (self.topArray.count != 0 && indexPath.section == 0) {
        if (indexPath.row < 3) {
            //置顶的前三个点击方向  Model:self.topArray[indexPath.row]
            
            return;
        }
        //更多的点击方向
        return ;
    }
    //下面列表的点击方向  Model:self.mainArray[self.sortBy][indexPath.row];
    return;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.topArray.count != 0 && indexPath.section == 0) {
        if (indexPath.row < 3) {
            LQSForumDetailTopCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LQSForumDetailTopCell"];
            cell.model = self.topArray[indexPath.row];
            return cell;
        }
        return [tableView dequeueReusableCellWithIdentifier:@"LQSForumDetailTopMoreCell"];
    }
    LQSForumDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQSForumDetailCell"];
    cell.model = self.mainArray[self.sortBy][indexPath.row];
    return cell;
}

@end
