//
//  viewerViewController.m
//  myOrgForum
//
//  Created by 周双 on 16/6/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSShijieViewController.h"
#define kMargin 10
@interface LQSShijieViewController ()<LQSWaterFlowViewDelegate,LQSWaterFlowViewDataSource>
//tiezi
@property (nonatomic, strong) NSMutableArray *discoriesArr;
@property (nonatomic, weak) LQSWaterFlowView *waterFlowView;
@property (nonatomic,assign) NSUInteger page;
@property (nonatomic,strong) NSMutableArray *disArr;
@end

@implementation LQSShijieViewController

- (NSMutableArray *)discoriesArr
{
    if (_discoriesArr == nil) {
        self.discoriesArr = [NSMutableArray array];
        
    }
    return _discoriesArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    请求数据
    self.page = 1;
    [self shijieDataRequestWithPage:self.page];
//    需要初始化数据
    [self.discoriesArr addObjectsFromArray:self.disArr];
    [self createCell];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.waterFlowView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    self.waterFlowView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    
    [self.waterFlowView.mj_header beginRefreshing];

}

- (void)shijieDataRequestWithPage:(NSUInteger)page{
    
    if ([[NSString stringWithFormat:@"%lud",self.page] isEqualToString:@"1"] && self.discoriesArr) {
        [self.discoriesArr removeAllObjects];
    }

    NSString *loginUrlStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"r"] = @"portal/newslist";

    params[@"latitude"] = @"39.981122";
    params[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    params[@"accessSecret"] = @"cd090971f3f83391cd4ddc034638c";
    params[@"accessToken"] = @"f9514b902a334d6c0b23305abd46d";
    params[@"page"] = [NSString stringWithFormat:@"%lud",(unsigned long)self.page];
    params[@"longitude"] = @"116.300859";
    params[@"sdkVersion"] = @"2.4.0";
    params[@"pageSize"] = @"20";
    params[@"apphash"] = @"fba2d7a8";
    params[@"moduleId"] = @"1";
    [session POST:loginUrlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];//[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"返回数据：%@",dict);
        if (self.disArr.count > 0) {
            [self.disArr removeAllObjects];
        }else{
        
            NSMutableArray *disArr = [[NSMutableArray alloc] init];
            self.disArr = disArr;
        }
        self.disArr = [LQSShijieDataListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        [self.waterFlowView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];

}

//创建瀑布流布局
- (void)createCell{

    LQSWaterFlowView *waterFlowView = [[LQSWaterFlowView alloc] init];
    waterFlowView.backgroundColor = [UIColor cyanColor];
    //    跟谁父控件的尺寸而自动伸缩
    waterFlowView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    waterFlowView.frame = CGRectMake(0, 64 + 40, kScreenWidth, kScreenHeight - 64 - 40);
    waterFlowView.dataSource = self;
    waterFlowView.delegate = self;
    [self.view addSubview:waterFlowView];
    self.waterFlowView = waterFlowView;
}

- (void)loadNewShops
{
    self.page = 1;
    [self shijieDataRequestWithPage:self.page];
    [self.discoriesArr insertObjects:self.disArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.disArr.count)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新瀑布流控件
        [self.waterFlowView reloadData];
        // 停止刷新
        [self.waterFlowView.mj_header endRefreshing];
    });
    
}

- (void)loadMoreShops
{
    self.page++;
    [self shijieDataRequestWithPage:self.page];
    [self.discoriesArr addObjectsFromArray:self.disArr];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新瀑布流控件
        [self.waterFlowView reloadData];
        // 停止刷新
        [self.waterFlowView.mj_footer endRefreshing];
    });


}



#pragma mark - dataSource&delegate
- (NSUInteger)numberOfCellsInWaterflowView:(LQSWaterFlowView *)waterflowView
{
    return self.discoriesArr.count;
}

- (LQSWaterFlowViewCell *)waterflowView:(LQSWaterFlowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    LQSDiscoverCell *cell = [LQSDiscoverCell cellWithWaterflowView:waterflowView];
    cell.shijieDataModel = self.discoriesArr[index];
    return cell;
    
}

- (NSUInteger)numberOfColumnsInWaterflowView:(LQSWaterFlowView *)waterflowView
{
    return 2;
    
}

- (CGFloat)waterflowView:(LQSWaterFlowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    
    LQSShijieDataListModel *shijieModel = [self.discoriesArr objectAtIndex:index];
    return waterflowView.cellWidth * shijieModel.ratio + 35;
    
    }



@end
