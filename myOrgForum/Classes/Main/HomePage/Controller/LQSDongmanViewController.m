//
//  LQSVoiceViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSDongmanViewController.h"

@interface LQSDongmanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dongManDataArr;
    NSMutableArray *_dongManDataArray;
    NSMutableArray *_picListArr;


}
@property (nonatomic, assign) NSUInteger page;

@end

@implementation LQSDongmanViewController

- (void)dealloc{
    _tableView = nil;
    _dongManDataArr = nil;
    _dongManDataArray = nil;
    _picListArr = nil;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dongManDataArray = [NSMutableArray array];
    _dongManDataArr = [NSMutableArray array];
    self.page = 1;
    [_dongManDataArray addObjectsFromArray:_dongManDataArr];
    [self reloadDongmanDateRequestWithPage:self.page];
//创建tableview
    [self createTableView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.page = 1;
    [_dongManDataArray addObjectsFromArray:_dongManDataArr];
    [self reloadDongmanDateRequestWithPage:self.page];

    
    
    __unsafe_unretained UITableView *tableView = _tableView;
    //    上啦刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    [tableView.mj_header beginRefreshing];

}

- (void)loadNewData
{
    self.page = 1;
    [self reloadDongmanDateRequestWithPage:self.page];
    [_dongManDataArray insertObjects:_dongManDataArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _dongManDataArr.count)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //    刷新表格
    [_tableView reloadData];
    //停止刷新
    [_tableView.mj_header endRefreshing];
    });
}

- (void)loadMoreData
{
    
    self.page++;
    [self reloadDongmanDateRequestWithPage:self.page];
    
    [_dongManDataArray addObjectsFromArray:_dongManDataArr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

    //    刷新表格
    [_tableView reloadData];
    [_tableView.mj_footer endRefreshing];
    });
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 5.5, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];



}

- (void)reloadDongmanDateRequestWithPage:(NSUInteger)page
{
    
    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"portal/newslist";
    paramDic[@"sdkVersion"] = @"2.4.0";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    paramDic[@"pageSize"] = @"20";
    paramDic[@"longitude"] = @"116.300859";
    paramDic[@"moduleId"] = @"3";
    paramDic[@"latitude"] = @"39.981122";
    paramDic[@"accessToken"] = @"f9514b902a334d6c0b23305abd46d";
    paramDic[@"page"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.page];
    paramDic[@"accessSecret"] = @"cd090971f3f83391cd4ddc034638c";
    paramDic[@"circle"] = @"0";
    paramDic[@"isImageList"] = @"1";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        if (_dongManDataArr.count > 0 && weakSelf.page == 1) {
            [_dongManDataArr removeAllObjects];
        }else{
            
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            _dongManDataArr = tempArr;
        }
        _dongManDataArr = [LQSShijieDataListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        _picListArr = [NSMutableArray array];
        _picListArr = [LQSShijieDataModel mj_objectArrayWithKeyValuesArray:dict[@"piclist"]];
//        [_dongManDataArray addObjectsFromArray:_dongManDataArr];
        
        if (_dongManDataArray.count <= 0 && _page == 1) {
            [_dongManDataArray addObjectsFromArray:_dongManDataArr];
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        kNetworkNotReachedMessage;
        [_tableView.mj_header endRefreshing];

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _tableView.mj_footer.hidden = _dongManDataArr.count == 0;
    return _dongManDataArray.count;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"CELLForRowAtIndexPath,section:%zd,row:%zd",indexPath.section,indexPath.row);
    static NSString *identifier = @"dongManCell";
    LQSDongmanTableViewCell *dongmancell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (dongmancell == nil) {
        dongmancell = [[LQSDongmanTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1                reuseIdentifier:identifier];
    }
    
    
    [dongmancell pushesDongmanDataModel:[_dongManDataArray objectAtIndex:indexPath.row]];
    return dongmancell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
NSLog(@"heightForRowAtIndexPath,section:%zd,row:%zd",indexPath.section,indexPath.row);
    LQSDongmanTableViewCell *dongmanCell = (LQSDongmanTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return dongmanCell.cellHeight;



}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    LQSBBSDetailViewController *detailVc = [LQSBBSDetailViewController new];
    LQSDongmanListModel *model = [_dongManDataArray objectAtIndex:indexPath.row];
//    detailVc.selectModel.board_id = model.board_id;
//    detailVc.selectModel.topicId = model.fid;
    detailVc.boardID = model.board_id;
    detailVc.topicID = model.source_id;
    [self.navigationController pushViewController:detailVc animated:NO];




}
@end
