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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.page = 1;
    [_dongManDataArray addObjectsFromArray:_dongManDataArr];
    [self reloadDongmanDateRequestWithPage:self.page];
    self.view.backgroundColor = [UIColor blueColor];
//创建tableview
    [self createTableView];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    上啦刷新
    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    [_tableView.mj_header beginRefreshing];

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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 40, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
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
    paramDic[@"page"] = [NSString stringWithFormat:@"%lud",(unsigned long)self.page];
    paramDic[@"accessSecret"] = @"cd090971f3f83391cd4ddc034638c";
    paramDic[@"circle"] = @"0";
    paramDic[@"isImageList"] = @"1";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        if (_dongManDataArr.count > 0 && self.page == 1) {
            [_dongManDataArr removeAllObjects];
        }else{
            
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            _dongManDataArr = tempArr;
        }
        _dongManDataArr = [LQSShijieDataListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        _picListArr = [NSMutableArray array];
        _picListArr = [LQSShijieDataModel mj_objectArrayWithKeyValuesArray:dict[@"piclist"]];
        _dongManDataArray = [NSMutableArray array];
        [_dongManDataArray addObjectsFromArray:_dongManDataArr];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        
    }];
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dongManDataArray.count;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

    LQSDongmanTableViewCell *dongmanCell = (LQSDongmanTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return dongmanCell.cellHeight;



}
@end
