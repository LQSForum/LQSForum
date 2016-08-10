//
//  LQSIntroduceViewController.m
//  myOrgForum
//  功能：首页
//  Created by 徐经纬 on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSIntroduceViewController.h"
#import "LQSIntroduceMainListModel.h"
#import "LQSintroduceMainlistCell.h"
#define KTITLEBTNTAGBEGAN 20160716


@interface LQSIntroduceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainList;
@property (nonatomic, strong) NSMutableArray *lbDataArrA;//最上轮播数据
@property (nonatomic, strong) NSMutableArray *btnDataArrB;//八个按钮数据
@property (nonatomic, strong) LQSIntroduceMainListModel *LQWSXDataC;//龙泉闻思修
@property (nonatomic, strong) NSMutableArray *XFXZDataD;//学佛小组
@property (nonatomic, strong) LQSIntroduceMainListModel *DHSKSDataE;//大和尚开示
@property (nonatomic, strong) NSMutableArray *KSDataF;//师父法语开示


@end



@implementation LQSIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self postForData];
    
}

- (void)createMainlist
{
    self.mainList.delegate = self;
    self.mainList.dataSource = self;
    [self.view addSubview:self.mainList];
    self.mainList.backgroundColor = [UIColor yellowColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postForData];
}
#pragma mark - postFordata
- (void)postForData
{
    NSString *loginUrlStr = @"http://forum.longquanzs.org/mobcent/app/web/index.php?";
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.requestSerializer = [AFHTTPRequestSerializer serializer];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"r"] = @"app/moduleconfig";
    params[@"egnVersion"] = @"v2035.2";
    params[@"sdkVersion"] = @"2.4.3.0";
    params[@"apphash"] = @"0b8cb156";
    params[@"configId"] = @"0";
    params[@"moduleId"] = @"6";
    params[@"accessToken"] = @"7e3972a7a729e541ee373e7da3d06";//换
    params[@"accessSecret"] = @"39a68e4d5473e75669bce2d70c4b9";
    params[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    /*
     r:app/moduleconfig
     egnVersion:v2035.2
     sdkVersion:2.4.3.0
     apphash:0b8cb156
     configId:0
     moduleId:6
     accessToken:7e3972a7a729e541ee373e7da3d06
     accessSecret:39a68e4d5473e75669bce2d70c4b9
     forumKey:BW0L5ISVRsOTVLCTJx
     */
    [session POST:loginUrlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        [self cleanData];
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];//[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"返回数据：%@",dict);
        [self getDataModelFor:dict];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];

}

- (void)cleanData
{
    [self.lbDataArrA removeAllObjects];
    [self.KSDataF removeAllObjects];
    [self.XFXZDataD removeAllObjects];
    self.LQWSXDataC = nil;
    [self.btnDataArrB  removeAllObjects];
    self.DHSKSDataE = nil;
}
- (void)getDataModelFor:(NSDictionary *)dataDic
{
    NSMutableArray *yChengData = nil;
    if (dataDic[@"body"][@"module"][@"componentList"]) {
       yChengData = dataDic[@"body"][@"module"][@"componentList"];
    }
    if (yChengData.count >= 6) {
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
            lbModel.topicId = LQSTR(sChengData[@"exParams"][@"topicId"]);
            lbModel.redirect = LQSTR(sChengData[@"exParams"][@"redirect"]);
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
            bModel.topicId = LQSTR(sChengData[@"exParams"][@"topicId"]);
            bModel.redirect = LQSTR(sChengData[@"exParams"][@"redirect"]);
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
            bModel.topicId = LQSTR(sChengData[@"exParams"][@"topicId"]);
            bModel.redirect = LQSTR(sChengData[@"exParams"][@"redirect"]);
            bModel.id = LQSTR(sChengData[@"id"]);
            [self.btnDataArrB addObject:bModel];
        }
        //龙泉闻思修
        NSDictionary *eChengDataDic;
        eChengDataDic = yChengData[2][@"componentList"][0][@"componentList"][0];
        if (eChengDataDic) {
            self.LQWSXDataC.px = LQSTR(eChengDataDic[@"px"]);
            self.LQWSXDataC.type = LQSTR(eChengDataDic[@"type"]);
            self.LQWSXDataC.icon = LQSTR(eChengDataDic[@"icon"]);
            self.LQWSXDataC.title = LQSTR(eChengDataDic[@"title"]);
            self.LQWSXDataC.desc = LQSTR(eChengDataDic[@"desc"]);
            self.LQWSXDataC.topicId = LQSTR(eChengDataDic[@"exParams"][@"topicId"]);
            self.LQWSXDataC.redirect = LQSTR(eChengDataDic[@"exParams"][@"redirect"]);
        }
        //活动报名、学佛小组
        eChengData = yChengData[3][@"componentList"][0][@"componentList"];
        for (NSDictionary *sChengData in eChengData) {
            LQSIntroduceMainListModel *xModel = [[LQSIntroduceMainListModel alloc] init];
            xModel.px = LQSTR(sChengData[@"px"]);
            xModel.type = LQSTR(sChengData[@"type"]);
            xModel.icon = LQSTR(sChengData[@"icon"]);
            xModel.title = LQSTR(sChengData[@"title"]);
            xModel.desc = LQSTR(sChengData[@"desc"]);
            xModel.forumId = LQSTR(sChengData[@"forumId"]);
            xModel.topicId = LQSTR(sChengData[@"exParams"][@"topicId"]);
            xModel.redirect = LQSTR(sChengData[@"exParams"][@"redirect"]);
            xModel.id = LQSTR(sChengData[@"id"]);
            [self.XFXZDataD addObject:xModel];
        }
        //师父开示
        eChengData = yChengData[3][@"componentList"][0][@"componentList"];
        for (NSDictionary *sChengData in eChengData) {
            LQSIntroduceMainListModel *xModel = [[LQSIntroduceMainListModel alloc] init];
            xModel.px = LQSTR(sChengData[@"px"]);
            xModel.type = LQSTR(sChengData[@"type"]);
            xModel.icon = LQSTR(sChengData[@"icon"]);
            xModel.title = LQSTR(sChengData[@"title"]);
            xModel.desc = LQSTR(sChengData[@"desc"]);
            xModel.forumId = LQSTR(sChengData[@"forumId"]);
            xModel.topicId = LQSTR(sChengData[@"exParams"][@"topicId"]);
            xModel.redirect = LQSTR(sChengData[@"exParams"][@"redirect"]);
            xModel.id = LQSTR(sChengData[@"id"]);
            [self.XFXZDataD addObject:xModel];
        }

        [self createMainlist];
        [self.mainList reloadData];
    }
   
}
#pragma mark - 属性懒加载
- (NSMutableArray *)lbDataArrA
{
    if (!_lbDataArrA) {
        _lbDataArrA = [NSMutableArray array];
    }
    return _lbDataArrA;
}

- (NSMutableArray *)XFXZDataD
{
    if (!_XFXZDataD) {
        _XFXZDataD = [NSMutableArray array];
    }
    return _XFXZDataD;
}

- (NSMutableArray *)btnDataArrB
{
    if (!_btnDataArrB) {
        _btnDataArrB = [NSMutableArray array];
    }
    return _btnDataArrB;
}

- (NSMutableArray *)KSDataF
{
    if (!_KSDataF) {
        _KSDataF = [NSMutableArray array];
    }
    return _KSDataF;
}

- (LQSIntroduceMainListModel *)DHSKSDataE
{
    if (!_DHSKSDataE) {
        _DHSKSDataE = [[LQSIntroduceMainListModel alloc] init];
    }
    return _DHSKSDataE;
}

- (LQSIntroduceMainListModel *)LQWSXDataC
{
    if (!_LQWSXDataC) {
        _LQWSXDataC = [[LQSIntroduceMainListModel alloc] init];
    }
    return _LQWSXDataC;
}

#pragma mark - tableview mainlist
- (UITableView *)mainList
{
    if (!_mainList) {
        _mainList = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStyleGrouped];
    }
    return _mainList;
}

#pragma mark - mainList delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 5) {
        return self.KSDataF.count;
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
        }case 2:{
            height = KLQScreenFrameSize.width *180/750;
            break;
        }case 3:{
            height = KLQScreenFrameSize.width *190/750;
            break;
        }case 4:{
            height = KLQScreenFrameSize.width *230/750;
            break;
        }case 5:{
            height = KLQScreenFrameSize.width *180/750;
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
    switch (indexPath.section) {
        case 0:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.lbDataArrA}];
            [cell setCellForIndexPath:indexPath];
            break;
        }case 1:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.btnDataArrB}];
            [cell setCellForIndexPath:indexPath];
            break;
        }case 2:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.LQWSXDataC}];
            [cell setCellForIndexPath:indexPath];
            break;
        }case 3:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.XFXZDataD}];
            [cell setCellForIndexPath:indexPath];
            break;
        }case 4:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.DHSKSDataE}];
            [cell setCellForIndexPath:indexPath];
            break;
        }case 5:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.KSDataF}];
            [cell setCellForIndexPath:indexPath];
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

@end
