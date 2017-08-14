//
//  LQSRecommendViewController.m
//  myOrgForum
//
//  Created by wangbo on 2017/6/11.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSRecommendViewController.h"
#import "LQSintroduceMainlistCell.h"
#import "LQSRecommendListTableViewCell.h"
#import "LQSRecommendListModel.h"

@interface LQSRecommendViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) UITableView *recommendTableView;
@property (nonatomic, strong) NSMutableArray *lbDataArrA;       //最上轮播数据
@property (nonatomic, strong) NSMutableArray *btnDataArrB;      //按钮数据
@property (nonatomic, strong) NSMutableArray *recommendArray;   //推荐列表
@property (nonatomic, strong) NSMutableArray *recommendNewArray;//推荐新增列表 下拉新增数组

@end

@implementation LQSRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createRecommendlist];
    self.page = 1;
    [self reloadRecommendDateRequestWithPage:self.page];
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

- (void)createRecommendlist
{
    self.recommendTableView.delegate = self;
    self.recommendTableView.dataSource = self;
    [self.view addSubview:self.recommendTableView];
    self.recommendTableView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
}

#pragma mark - getter
- (NSMutableArray *)lbDataArrA
{
    if (!_lbDataArrA) {
        _lbDataArrA = [NSMutableArray array];
    }
    return _lbDataArrA;
}

- (NSMutableArray *)btnDataArrB
{
    if (!_btnDataArrB) {
        _btnDataArrB = [NSMutableArray array];
    }
    return _btnDataArrB;
}

- (NSMutableArray *)recommendArray
{
    if (!_recommendArray) {
        _recommendArray = [NSMutableArray array];
    }
    return _recommendArray;
}

- (NSMutableArray *)recommendNewArray {
    if (!_recommendArray) {
        _recommendArray = [NSMutableArray array];
    }
    
    return _recommendArray;
}

- (UITableView *)recommendTableView
{
    if (!_recommendTableView) {
        _recommendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStyleGrouped];
        [self setupRefresh];
    }
    _recommendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _recommendTableView.showsVerticalScrollIndicator = NO;
    
    return _recommendTableView;
}

#pragma mark - tableview refresh data
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    _recommendTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    
    // 2.添加上拉刷新控件
    _recommendTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
}

/**
 *  加载最新的数据
 */
- (void)loadNewStatus
{
    self.page = 1;
    [self reloadRecommendDateRequestWithPage:self.page];
    //[self.cishanArray insertObjects:self.cishanArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.cishanArr.count)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_recommendTableView reloadData];
        // 停止刷新
        [_recommendTableView.mj_header endRefreshing];
    });
    
}
/**
 *  加载更多的数据 追加
 */
- (void)loadMoreStatus
{
    self.page++;
    [self reloadRecommendDateRequestWithPage:self.page];
    //[self.cishanArray addObjectsFromArray:self.cishanArr];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新瀑布流控件
        [_recommendTableView reloadData];
        // 停止刷新
        [_recommendTableView.mj_footer endRefreshing];
    });
}

- (void)reloadRecommendDateRequestWithPage:(NSUInteger)page
{
//    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSString *baseStr = @"http://lqs.zphoo.com/mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"forum/topiclistex";
    paramDic[@"isImageList"] = @"1";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    
//    paramDic[@"accessSecret"] = @"cd090971f3f83391cd4ddc034638c";
//    paramDic[@"accessToken"] = @"f9514b902a334d6c0b23305abd46d";
//    
//    paramDic[@"accessToken"] = @"7e3972a7a729e541ee373e7da3d06";//换
//    paramDic[@"accessSecret"] = @"39a68e4d5473e75669bce2d70c4b9";
//    
    paramDic[@"apphash"] = @"5d7f7891";
    paramDic[@"accessToken"] = @"83e1f2e3b07cc0629ac89ed355920";
    paramDic[@"accessSecret"] = @"a742cf58f0d3c28e164f9d9661b6f";
    
    NSMutableDictionary *sortsDic = [NSMutableDictionary dictionary];
    sortsDic[@"type"] = @"0";
//    paramDic[@"sorts"] = sortsDic;
//    [paramDic setObject:sortsDic forKey:@"sorts"];
    paramDic[@"sortid"] = @"0";
    paramDic[@"orderby"] = @"marrow";
    paramDic[@"boardId"] = @"0";
    paramDic[@"topOrder"] = @"1";
    paramDic[@"egnVersion"] = @"v2091.5";
    paramDic[@"page"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.page];
    paramDic[@"circle"] = @"0";
    paramDic[@"sdkVersion"] = @"2.5.0.0";
//    paramDic[@"apphash"] = @"0b8cb156";
//    paramDic[@"apphash"] = @"826f2657";
    paramDic[@"pageSize"] = @"20";
    
//    paramDic[@"longitude"] = @"116.300859";
//    paramDic[@"moduleId"] = @"2";
//    paramDic[@"latitude"] = @"39.981122";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"tuijian--------sucess");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        //        数据模型放到frame模型
//        if (weakSelf.cishanArray.count > 0 && weakSelf.page == 1) {
//            [weakSelf.cishanArr removeAllObjects];
//        }else{
//            weakSelf.cishanArr = [LQSCishanListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
//        }
//        if (weakSelf.cishanArray.count <= 0 && weakSelf.page == 1) {
//            [weakSelf.cishanArray addObjectsFromArray:weakSelf.cishanArr];
//        }
        
//        NSError *error;
//        NSDate *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//        
//        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        [weakSelf cleanData];
//        [self getDataModelFor:dict];
        
        [weakSelf refreshDataWithDict:dict];
        
        [_recommendTableView reloadData];
        [_recommendTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"tuijian---------failure");
        [_recommendTableView.mj_header endRefreshing];
        kNetworkNotReachedMessage;
    }];
}

- (void)cleanData {
    [self.lbDataArrA removeAllObjects];
    [self.btnDataArrB removeAllObjects];
    [self.recommendArray removeAllObjects];
    [self.recommendNewArray removeAllObjects];
}

- (void)refreshDataWithDict:(NSDictionary *)dataDic {
    if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSMutableArray *list = nil;
    
    if (dataDic[@"list"]) {
        list = dataDic[@"list"];
    }
    
    if ([list count] > 0) {
        if (1 == self.page) {
            if ([self.recommendNewArray count] > 0) {
                [self.recommendNewArray removeAllObjects];
            }
            
            if ([self.recommendArray count] > 0) {
                [self.recommendArray removeAllObjects];
            }
            //给数组赋值
            for (NSDictionary *sChengData in list) {
                LQSRecommendListModel *model = [self getModelWithDict:sChengData];
                if (sChengData) {
                    [self.recommendArray addObject:model];
                }
            }
        } else {
            if ([self.recommendNewArray count] > 0) {
                [self.recommendNewArray removeAllObjects];
            }
            //给数组添加值
            for (NSDictionary *sChengData in list) {
                LQSRecommendListModel *model = [self getModelWithDict:sChengData];
                if (sChengData) {
                    [self.recommendNewArray addObject:model];
                }
            }
            
            if ([self.recommendNewArray count] > 0) {
                [self.recommendArray addObjectsFromArray:self.recommendNewArray];
            }
        }
    }
}

- (LQSRecommendListModel *)getModelWithDict:(NSDictionary *)dict {
//    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
//        return nil;
//    }
    
    LQSRecommendListModel *model = [[LQSRecommendListModel alloc] initWithDictionary:dict];
    
    return model;
}

- (void)getDataModelFor:(NSDictionary *)dataDic
{
    NSMutableArray *yChengData = nil;
    if (dataDic[@"body"][@"module"][@"componentList"]) {
        yChengData = dataDic[@"body"][@"module"][@"componentList"];
    }
    if (yChengData.count >= 5) {
        //轮播数据
        NSArray *arr = [yChengData objectAtIndex: 0][@"componentList"];
        
        NSArray *eChengData = [arr[0] objectForKey:@"componentList"];
        for (NSDictionary *sChengData in eChengData) {
            LQSIntroduceMainListModel *lbModel = [[LQSIntroduceMainListModel alloc] init];
            lbModel.px = LQSTR(sChengData[@"px"]);
            lbModel.type = LQSTR(sChengData[@"type"]);
            lbModel.icon = LQSTR(sChengData[@"icon"]);
            lbModel.title = LQSTR(sChengData[@"title"]);
            lbModel.desc = LQSTR(sChengData[@"desc"]);
            lbModel.topicId = LQSTR(sChengData[@"extParams"][@"topicId"]);
            lbModel.redirect = LQSTR(sChengData[@"extParams"][@"redirect"]);
            lbModel.id = LQSTR(sChengData[@"id"]);
            [self.lbDataArrA addObject:lbModel];
        }
        //八按钮数据
        eChengData = yChengData[1][@"componentList"][0][@"componentList"];
        for (NSDictionary *sChengData in eChengData) {
            LQSIntroduceMainListModel *bModel = [[LQSIntroduceMainListModel alloc] init];
            bModel.px = LQSTR(sChengData[@"px"]);
            bModel.type = LQSTR(sChengData[@"type"]);
            bModel.icon = LQSTR(sChengData[@"icon"]);
            bModel.title = LQSTR(sChengData[@"title"]);
            bModel.desc = LQSTR(sChengData[@"desc"]);
            bModel.topicId = LQSTR(sChengData[@"extParams"][@"topicId"]);
            bModel.redirect = LQSTR(sChengData[@"extParams"][@"redirect"]);
            bModel.id = LQSTR(sChengData[@"id"]);
            [self.btnDataArrB addObject:bModel];
        }
        eChengData = yChengData[1][@"componentList"][1][@"componentList"];
        for (NSDictionary *sChengData in eChengData) {
            LQSIntroduceMainListModel *bModel = [[LQSIntroduceMainListModel alloc] init];
            bModel.px = LQSTR(sChengData[@"px"]);
            bModel.type = LQSTR(sChengData[@"type"]);
            bModel.icon = LQSTR(sChengData[@"icon"]);
            bModel.title = LQSTR(sChengData[@"title"]);
            bModel.desc = LQSTR(sChengData[@"desc"]);
            bModel.topicId = LQSTR(sChengData[@"extParams"][@"topicId"]);
            bModel.redirect = LQSTR(sChengData[@"extParams"][@"redirect"]);
            bModel.id = LQSTR(sChengData[@"id"]);
            [self.btnDataArrB addObject:bModel];
        }
        
        //师父开示
        eChengData = yChengData[4][@"componentList"][0][@"componentList"];
        
        if (1 == self.page) {
            if ([self.recommendNewArray count] > 0) {
                [self.recommendNewArray removeAllObjects];
            }
            
            if ([self.recommendArray count] > 0) {
                [self.recommendArray removeAllObjects];
            }
            //给数组赋值
            for (NSDictionary *sChengData in eChengData) {
                LQSIntroduceMainListModel *xModel = [[LQSIntroduceMainListModel alloc] init];
                xModel.px = LQSTR(sChengData[@"px"]);
                xModel.type = LQSTR(sChengData[@"type"]);
                xModel.icon = LQSTR(sChengData[@"icon"]);
                xModel.title = LQSTR(sChengData[@"title"]);
                xModel.desc = LQSTR(sChengData[@"desc"]);
                xModel.forumId = LQSTR(sChengData[@"forumId"]);
                xModel.topicId = LQSTR(sChengData[@"extParams"][@"topicId"]);
                xModel.redirect = LQSTR(sChengData[@"extParams"][@"redirect"]);
                xModel.id = LQSTR(sChengData[@"id"]);
                [self.recommendArray addObject:xModel];
            }
        } else {
            if ([self.recommendNewArray count] > 0) {
                [self.recommendNewArray removeAllObjects];
            }
            //给数组添加值
            for (NSDictionary *sChengData in eChengData) {
                LQSIntroduceMainListModel *xModel = [[LQSIntroduceMainListModel alloc] init];
                xModel.px = LQSTR(sChengData[@"px"]);
                xModel.type = LQSTR(sChengData[@"type"]);
                xModel.icon = LQSTR(sChengData[@"icon"]);
                xModel.title = LQSTR(sChengData[@"title"]);
                xModel.desc = LQSTR(sChengData[@"desc"]);
                xModel.forumId = LQSTR(sChengData[@"forumId"]);
                xModel.topicId = LQSTR(sChengData[@"extParams"][@"topicId"]);
                xModel.redirect = LQSTR(sChengData[@"extParams"][@"redirect"]);
                xModel.id = LQSTR(sChengData[@"id"]);
                [self.recommendNewArray addObject:xModel];
            }
            
            if ([self.recommendNewArray count] > 0) {
                [self.recommendArray addObjectsFromArray:self.recommendNewArray];
            }
        }
    }
}

#pragma mark - mainList delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return self.recommendArray.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:{
            height = KLQScreenFrameSize.width *380/750;
            break;
        }case 1:{
            height = KLQScreenFrameSize.width *360/750;
            break;
        }
        case 2:{
//            height = KLQScreenFrameSize.width *180/750;
            
            if (indexPath.row >= 0 && indexPath.row < [self.recommendArray count]) {
                LQSRecommendListModel *listModel = [self.recommendArray objectAtIndex:indexPath.row];
                height = [LQSRecommendListTableViewCell heightWithRecommendListModel:listModel];
            }
            break;
        }
            
        default:
            break;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQSintroduceMainlistCell *cell = [[LQSintroduceMainlistCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.myCtrl = self;
    switch (indexPath.section) {
        case 0:{
//            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.lbDataArrA,@"indexPath":indexPath}];
            //            [cell setCellForIndexPath:indexPath];
            break;
        }case 1:{
//            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.btnDataArrB,@"indexPath":indexPath}];
            //            [cell setCellForIndexPath:indexPath];
            break;
        }
        case 2:{
//            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.recommendArray,@"indexPath":indexPath}];
            //            [cell setCellForIndexPath:indexPath];
            
            LQSRecommendListTableViewCell *cell = [[LQSRecommendListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendListCell"];
            
            if (indexPath.row >= 0 && indexPath.row < [self.recommendArray count]) {
                LQSRecommendListModel *listModel = [self.recommendArray objectAtIndex:indexPath.row];
                [cell updateCellWithModel:listModel];
            }
            
            return cell;
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 5.0;
    if (section == 2) {
        height = LQSgetHeight(60);
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] init];
//    return view;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        //师父法语开示点击
        NSLog(@"点击师父法语开示");
        LQSRecommendListModel *model = self.recommendArray[indexPath.row];
        if ([model.type isEqualToString:@"postlist"]) {
//            LQSBBSDetailViewController *vc = [[LQSBBSDetailViewController alloc] init];
//            vc.selectModel = model;
//            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

@end
