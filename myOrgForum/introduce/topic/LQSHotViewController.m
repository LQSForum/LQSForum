//
//  viewerViewController.m
//  myOrgForum
//
//  Created by 周双 on 16/6/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSHotViewController.h"

@interface LQSHotViewController ()<LQSWaterFlowViewDelegate,LQSWaterFlowViewDataSource>
//tiezi
@property (nonatomic, strong) NSMutableArray *discoriesArr;
@property (nonatomic, weak) LQSWaterFlowView *waterFlowView;

@end

@implementation LQSHotViewController

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
    // Do any additional setup after loading the view.
    //    discovery
    //    初始化数据
    
    
    //    瀑布流控件
    LQSWaterFlowView *waterFlowView = [[LQSWaterFlowView alloc] init];
    waterFlowView.backgroundColor = [UIColor cyanColor];
    //    跟谁父控件的尺寸而自动伸缩
    waterFlowView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    waterFlowView.frame = self.view.bounds;
    waterFlowView.dataSource = self;
    waterFlowView.delegate = self;
    [self.view addSubview:waterFlowView];
    self.waterFlowView = waterFlowView;
    
    //    集成刷新控件下拉刷新
    waterFlowView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestData:^{
            
            [waterFlowView.mj_header endRefreshing];
            [self loadNewDiscoveries];
            
        }];
    }];
    
    //    在导航栏下 main自动隐藏
    waterFlowView.mj_header.automaticallyChangeAlpha = YES;
    //上拉加载
    waterFlowView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreShops];
        [waterFlowView.mj_footer endRefreshing];
    }];
}

- (void)requestData:(void (^)(void))callback
{
    [LQSCoreManagerHandler httpRequestHorizonSuccess:^(id responseObject) {
        LQSHorizonDataModel *horizonModel = [LQSHorizonDataModel yy_modelWithDictionary:responseObject];
        
        
        
        
        
        
        
        if (callback) {
            callback();
        }
    } failure:^(NSError *error) {
        
        if (callback) {
            callback();
        }
        
        
        
    }];
    
    
    
    
    
    
}

- (void)loadNewDiscoveries
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 加载1.plist
        NSArray *newShops = [LQSDiscover objectArrayWithFilename:@"1.plist"];
        [self.discoriesArr insertObjects:newShops atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newShops.count)]];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新瀑布流控件
        [self.waterFlowView reloadData];
        
        // 停止刷新
        [self.waterFlowView.mj_header endRefreshing];
    });
    
    
}

- (void)loadMoreShops
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 加载3.plist
        NSArray *newShops = [LQSDiscover objectArrayWithFilename:@"3.plist"];
        [self.discoriesArr addObjectsFromArray:newShops];
    });
    
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
    cell.discover = self.discoriesArr[index];
    return cell;
    
}

- (NSUInteger)numberOfColumnsInWaterflowView:(LQSWaterFlowView *)waterflowView
{
    return 2;
    
}

- (CGFloat)waterflowView:(LQSWaterFlowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    LQSDiscover *discover  = self.discoriesArr[index];
    return waterflowView.cellWidth * discover.h / discover.w;
    
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

@end
