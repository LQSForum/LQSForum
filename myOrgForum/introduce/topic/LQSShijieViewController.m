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
    self.view.backgroundColor = [UIColor greenColor];
    [self shijieDataRequest];

    

}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
//    请求数据
}

- (void)shijieDataRequest{
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
    params[@"page"] = @"1";
    params[@"longitude"] = @"116.300859";
    params[@"sdkVersion"] = @"2.4.0";
    params[@"pageSize"] = @"20";
    params[@"apphash"] = @"fba2d7a8";
    params[@"moduleId"] = @"1";
    [session POST:loginUrlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];//[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"返回数据：%@",dict);
//        LQSShijieDataModel *shijieModel = [];
        NSArray *disArr = [[NSArray alloc] init];
        disArr = [LQSShijieDataListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        [self.discoriesArr insertObjects:disArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, disArr.count)]];

        [self createCell];//请求成功创建控件
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
    waterFlowView.frame = self.view.bounds;
    waterFlowView.dataSource = self;
    waterFlowView.delegate = self;
    [self.view addSubview:waterFlowView];
    self.waterFlowView = waterFlowView;
}

#pragma mark - dataSource&delegate
- (NSUInteger)numberOfCellsInWaterflowView:(LQSWaterFlowView *)waterflowView
{
    return self.discoriesArr.count;
}

- (LQSWaterFlowViewCell *)waterflowView:(LQSWaterFlowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    LQSDiscoverCell *cell = [LQSDiscoverCell cellWithWaterflowView:waterflowView];
//    cell.discover = self.discoriesArr[index];
    return cell;
    
}

- (NSUInteger)numberOfColumnsInWaterflowView:(LQSWaterFlowView *)waterflowView
{
    return 2;
    
}

- (CGFloat)waterflowView:(LQSWaterFlowView *)waterflowView heightAtIndex:(NSUInteger)index
{
//    LQSDiscover *discover  = self.discoriesArr[index];
//    return waterflowView.cellWidth * discover.h / discover.w;
    return 200;
}



@end
