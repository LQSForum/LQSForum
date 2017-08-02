//
//  LQSForumAttentionView.m
//  myOrgForum
//
//  Created by 昱含 on 2017/5/9.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSForumAttentionView.h"
#import "LQSForumAttentionViewCell.h"
#import "LQSBBSDetailViewController.h"
#import "LQSForumDetailViewController.h"
#import "LQSUserManager.h"
#import "LQSNonAttentionDataView.h"

@interface LQSForumAttentionView ()<UITableViewDelegate,UITableViewDataSource,LQSForumAttentionViewCellDelegate>
/** 网络请求管理 */
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
/** 所有数据 */
@property (nonatomic, strong) NSMutableArray *allDataArray;
/** 页数 */
@property (nonatomic, assign) NSInteger pageNum;
/** 无数据页面 */
@property (nonatomic, strong) LQSNonAttentionDataView *nonDataView;
@end

@implementation LQSForumAttentionView

static NSString *const ForumAttentionCell = @"LQSForumAttentionCell";


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor lqs_colorWithHexString:@"#d8d8d8"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.nonDataView];
        //刷新
        [self headerRefresh];
        [self footerRefresh];
    }
    
    return self;
}

//下拉刷新
- (void)headerRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestAttentionData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
        [header beginRefreshing];
    
    // 设置header
    self.mj_header = header;
}

//上拉加载
- (void)footerRefresh
{
    MJRefreshBackNormalFooter *footer  = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestAttentionMoreData)];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
    if (![LQSUserManager isLoging]) {
        
        self.mj_footer.hidden = YES;
    }else{
        self.mj_footer.hidden = NO;
    }
}



#pragma Network
- (void)requestAttentionData
{
    // 判定是否登录,没登录则跳转登录,登录后则跳转用户主页
    if (![LQSUserManager isLoging]) {
        
        self.nonDataView.hidden = NO;
        [kAppDelegate showHUDMessage:@"您需要先登录才能继续本操作" hideDelay:1.0];
        [self.mj_header endRefreshing];
    }else{
        self.nonDataView.hidden = YES;
        self.pageNum = 1;
        NSString *urlString = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/followlist";
        NSDictionary *parameters = @{@"accessSecret":@"f24c29a8120733daf65db8635f049",
                                     @"accessToken":@"9681504c5bd171bdc02c2f66a4dee",
                                     @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                     @"apphash":@"7dd4b72a",
                                     @"page":@(self.pageNum)};
        [self loadAttentionDataWithUrlString:urlString parameters:parameters];
    }
    

}

- (void)loadAttentionDataWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters{
    
    [self.sessionManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.pageNum == 1) {
            [self.allDataArray removeAllObjects];
        }
        
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//        LQSLog(@"attention%@",dict);
        NSDictionary *head = dict[@"head"];
        NSString *code = head[@"errCode"];
        if ([code isEqualToString:@"00000000"]) {
            
            NSArray *listArr = dict[@"list"];
            for (NSDictionary *itemDict in listArr) {
                LQSForumAttentionModel *cellModel = [LQSForumAttentionModel yy_modelWithDictionary:itemDict];
                [self.allDataArray addObject:cellModel];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self  reloadData];
            });
        }
        
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
//        LQSLog(@"error%@",error);
        
    }];
    
    
}

- (void)requestAttentionMoreData
{
    if (![LQSUserManager isLoging]) {
        
        self.nonDataView.hidden = NO;
        [kAppDelegate showHUDMessage:@"您需要先登录才能继续本操作" hideDelay:1.0];
        [self.mj_footer endRefreshing];
        self.mj_footer.hidden = YES;
    }else{
        self.nonDataView.hidden = YES;
        self.pageNum++;
        NSString *urlString = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/followlist";
        NSDictionary *parameters = @{@"accessSecret":@"f24c29a8120733daf65db8635f049",
                                     @"accessToken":@"9681504c5bd171bdc02c2f66a4dee",
                                     @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                     @"apphash":@"7dd4b72a",
                                     @"page":@(self.pageNum)};
        [self loadAttentionDataWithUrlString:urlString parameters:parameters];
        
    }
}



#pragma mark - UITableViewDelegate/DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQSForumAttentionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForumAttentionCell];
    if (cell == nil) {
        cell = [[LQSForumAttentionViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ForumAttentionCell];
    }
    LQSForumAttentionModel *model = self.allDataArray[indexPath.row];
    cell.indexpathRow = indexPath.row;
    cell.model = model;
    cell.delegate = self;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    LQSForumAttentionModel *model = self.allDataArray[indexPath.row];
    LQSForumAttentionViewCell *cell = (LQSForumAttentionViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    height = [cell calculateCellHeightWithData:model];
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQSForumAttentionModel *model = self.allDataArray[indexPath.row];
    LQSBBSDetailViewController *detailVc = [[LQSBBSDetailViewController alloc]init];
    detailVc.boardID = [NSString stringWithFormat:@"%zd",model.attentionBoardID];
    detailVc.topicID = [NSString stringWithFormat:@"%zd",model.attentionTopicID];
    [self.lqs_parentViewController.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - CustomDelegate
- (void)pushToForumDetail:(LQSForumAttentionViewCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    LQSForumAttentionModel *model = self.allDataArray[indexPath.row];
    LQSForumDetailViewController* detailVC = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"ForumDetail"];
    detailVC.boardid = model.attentionBoardID;
//    detailVC.boardChild = 
    detailVC.title = model.attentionBoardName;
    [self.lqs_parentViewController.navigationController pushViewController:detailVC animated:YES];
}

- (void)pushToAuthorPage
{
    // 判定是否登录,没登录则跳转登录,登录后则跳转用户主页
    if (![LQSUserManager isLoging]) {
        //        跳转登陆
        LQLoginViewController *loginVc = [LQLoginViewController new];
        [self.lqs_parentViewController.navigationController presentViewController:loginVc animated:YES completion:nil];

    }else{
        if ([LQSUserManager isLoging]) {
            LQSHomePagePersonalMessageViewController *personalVc = [LQSHomePagePersonalMessageViewController new];
            [self.lqs_parentViewController.navigationController pushViewController:personalVc animated:YES];
        }else{
            LQLoginViewController *loginVC = [LQLoginViewController new];
            [self.lqs_parentViewController.navigationController presentViewController:loginVC animated:YES completion:nil];

            }
        }
    

}

#pragma mark - SetterAndGetter
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

- (NSMutableArray *)allDataArray{
    if (_allDataArray == nil) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (LQSNonAttentionDataView *)nonDataView
{
    if (_nonDataView == nil) {
        _nonDataView = [[LQSNonAttentionDataView alloc] initWithFrame:self.bounds];
        _nonDataView.hidden = YES;
    }
    return _nonDataView;
}

@end
