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
@property (nonatomic, strong) NSMutableArray *DHSKSDataE;//大和尚开示
@property (nonatomic, strong) NSMutableArray *KSDataF;//师父法语开示


@end



@implementation LQSIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self postForData];
    
}

- (void)createMainlist
{
    self.mainList.delegate = self;
    self.mainList.dataSource = self;
    [self.view addSubview:self.mainList];
    self.mainList.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self postForData];
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
        //龙泉闻思修
        NSDictionary *eChengDataDic;
        eChengDataDic = yChengData[2][@"componentList"][0][@"componentList"][0];
        if (eChengDataDic) {
            self.LQWSXDataC.px = LQSTR(eChengDataDic[@"px"]);
            self.LQWSXDataC.type = LQSTR(eChengDataDic[@"type"]);
            self.LQWSXDataC.icon = LQSTR(eChengDataDic[@"icon"]);
            self.LQWSXDataC.title = LQSTR(eChengDataDic[@"title"]);
            self.LQWSXDataC.desc = LQSTR(eChengDataDic[@"desc"]);
            self.LQWSXDataC.topicId = LQSTR(eChengDataDic[@"extParams"][@"topicId"]);
            self.LQWSXDataC.redirect = LQSTR(eChengDataDic[@"extParams"][@"redirect"]);
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
            xModel.topicId = LQSTR(sChengData[@"extParams"][@"topicId"]);
            xModel.redirect = LQSTR(sChengData[@"extParams"][@"redirect"]);
            xModel.id = LQSTR(sChengData[@"id"]);
            [self.XFXZDataD addObject:xModel];
        }
        //大和尚开示
        //[[[yChengData[4][@"componentList"] objectAtIndex:0] objectForKey:@"componentList"] objectAtIndex:1]
        eChengData = yChengData[4][@"componentList"][0][@"componentList"];
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
            [self.DHSKSDataE addObject:xModel];
        }

        //师父开示
        eChengData = yChengData[5][@"componentList"][0][@"componentList"];
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
            [self.KSDataF addObject:xModel];
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

- (NSMutableArray *)DHSKSDataE
{
    if (!_DHSKSDataE) {
        _DHSKSDataE = [NSMutableArray array];
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
    _mainList.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainList.showsVerticalScrollIndicator = NO;
    
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
    cell.myCtrl = self;
    switch (indexPath.section) {
        case 0:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.lbDataArrA,@"indexPath":indexPath}];
//            [cell setCellForIndexPath:indexPath];
            break;
        }case 1:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.btnDataArrB,@"indexPath":indexPath}];
//            [cell setCellForIndexPath:indexPath];
            break;
        }case 2:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.LQWSXDataC,@"indexPath":indexPath}];
//            [cell setCellForIndexPath:indexPath];
            break;
        }case 3:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.XFXZDataD,@"indexPath":indexPath}];
//            [cell setCellForIndexPath:indexPath];
            break;
        }case 4:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.DHSKSDataE,@"indexPath":indexPath}];
//            [cell setCellForIndexPath:indexPath];
            break;
        }case 5:{
            cell.paramDict =[NSMutableDictionary dictionaryWithDictionary: @{@"data":self.KSDataF,@"indexPath":indexPath}];
//            [cell setCellForIndexPath:indexPath];
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
    if (section == 5) {
        height = LQSgetHeight(60);
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    if (section == 5) {
        view.frame = CGRectMake(0, 0, self.view.frame.size.width, LQSgetHeight(60));
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 100, 15)];
        lab.text = @"师父法语开示";
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:13];
        lab.backgroundColor = [UIColor clearColor];
        [view addSubview:lab];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.frame.size.width - 10 - 50, 7, 50, 15);
        [btn setTitle:@"更多" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(moreNewsCilck:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:btn];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - KSingleLine_Width, view.frame.size.width, KSingleLine_Width)];
        [view addSubview:line];
        line.backgroundColor = [UIColor grayColor];
        view.backgroundColor = [UIColor whiteColor];
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5) {
        //师父法语开示点击
        NSLog(@"点击师父法语开示");
        LQSIntroduceMainListModel *model = self.KSDataF[indexPath.row];
        if ([model.type isEqualToString:@"postlist"]) {
            LQSBBSDetailViewController *vc = [[LQSBBSDetailViewController alloc] init];
            vc.selectModel = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

- (void)moreNewsCilck:(UIButton *)sender
{
    NSLog(@"点击更多");
}

//
//(
//{
//    componentList =     (
//                         {
//                             componentList =             (
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U5317\U4eac\U9f99\U6cc9\U5bfa2016\U5e74\U76c2\U5170\U76c6\U8282\U5b5d\U4eb2\U62a5\U6069\U6cd5\U4f1a\U3010\U901a\U77e5\U3011";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 0;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 62729;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201608/10/gNnjWTLJkdT2.jpg";
//                                                              iconStyle = image;
//                                                              id = c43;
//                                                              px = 1;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = postlist;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U5e38\U4f4f\U5fc3\U5f97\U4e4b\U201c\U4e03\U5915\U6709\U611f\U201d";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 62758;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201608/10/kBJ5Yaxb4tLs.jpg";
//                                                              iconStyle = image;
//                                                              id = c44;
//                                                              px = 2;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = postlist;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U3010\U73ed\U957f\U73ed\U7b14\U8bb0\U30112016-08-06 \U6687\U6ee1 ";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 62647;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201608/10/nQT7na2DJ5B6.jpg";
//                                                              iconStyle = image;
//                                                              id = c45;
//                                                              px = 3;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = postlist;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U62a4\U6301\U5e84\U4e25\U76f8\Uff0c\U4fee\U8865\U606d\U656c\U5fc3";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 62767;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201608/10/VdHsSU1qO2z7.jpg";
//                                                              iconStyle = image;
//                                                              id = c46;
//                                                              px = 4;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = postlist;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U8c01\U52a8\U4e86\U6211\U7684\U201c\U6211\U6267\U201d\Uff1f ";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 62821;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201608/10/EvyfskXdvSP0.jpg";
//                                                              iconStyle = image;
//                                                              id = c47;
//                                                              px = 5;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = postlist;
//                                                          }
//                                                          );
//                             desc = "";
//                             extParams =             {
//                                 articleId = 0;
//                                 dataId = 0;
//                                 fastpostForumIds =                 (
//                                 );
//                                 filter = "";
//                                 filterId = 0;
//                                 forumId = 0;
//                                 isShowMessagelist = 0;
//                                 isShowTopicTitle = 1;
//                                 listImagePosition = 2;
//                                 listSummaryLength = 40;
//                                 listTitleLength = 40;
//                                 moduleId = 0;
//                                 newsModuleId = 0;
//                                 order = 0;
//                                 orderby = "";
//                                 pageTitle = "";
//                                 redirect = "";
//                                 styleHeader =                 {
//                                     isShow = 1;
//                                     isShowMore = 1;
//                                     position = 0;
//                                     title = "";
//                                 };
//                                 subDetailViewStyle = flat;
//                                 subListStyle = flat;
//                                 titlePosition = left;
//                                 topicId = 0;
//                             };
//                             icon = "";
//                             iconStyle = image;
//                             id = c48;
//                             px = 0;
//                             style = layoutSlider;
//                             title = 1470803468274;
//                             type = layout;
//                         }
//                         );
//    desc = "";
//    extParams =     {
//        fastpostForumIds =         (
//        );
//        styleHeader =         {
//            isShow = 0;
//            isShowMore = 1;
//            moreComponent =             {
//                componentList =                 (
//                );
//                desc = "";
//                extParams =                 {
//                    articleId = 0;
//                    dataId = 0;
//                    fastpostForumIds =                     (
//                    );
//                    filter = "";
//                    filterId = 0;
//                    forumId = 0;
//                    isShowMessagelist = 0;
//                    isShowTopicTitle = 1;
//                    listBoardNameState = 0;
//                    listImagePosition = 2;
//                    listSummaryLength = 40;
//                    listTitleLength = 40;
//                    moduleId = 1;
//                    newsModuleId = 0;
//                    order = 0;
//                    orderby = "";
//                    redirect = "";
//                    subDetailViewStyle = flat;
//                    subListStyle = flat;
//                    titlePosition = left;
//                    topicId = 0;
//                };
//                icon = "";
//                iconStyle = image;
//                id = c178;
//                style = flat;
//                title = "";
//                type = forumlist;
//            };
//            position = 0;
//            title = "";
//        };
//        subDetailViewStyle = "<null>";
//        subListStyle = "<null>";
//    };
//    icon = "";
//    iconStyle = image;
//    id = c49;
//    px = 0;
//    style = layoutDefault;
//    title = "";
//    type = layout;
//},
//{
//    componentList =     (
//                         {
//                             componentList =             (
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U9f99\U6cc9\U4e4b\U58f0";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "http://wap.longquanzs.org";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 0;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201512/16/XNPZhlyNW7zM.png";
//                                                              iconStyle = circle;
//                                                              id = c50;
//                                                              px = 0;
//                                                              style = flat;
//                                                              title = "\U9f99\U6cc9\U4e4b\U58f0";
//                                                              type = webapp;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U65b0\U6d6a\U535a\U5ba2";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "http://blog.sina.com.cn/xuecheng";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 0;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201512/09/kqYBjo6t2g79.png";
//                                                              iconStyle = circle;
//                                                              id = c51;
//                                                              px = 0;
//                                                              style = flat;
//                                                              title = "\U65b0\U6d6a\U535a\U5ba2";
//                                                              type = webapp;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U65b0\U6d6a\U5fae\U535a";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "http://weibo.com/xuecheng";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 0;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201512/09/t4Mub32jGmvY.png";
//                                                              iconStyle = circle;
//                                                              id = c52;
//                                                              px = 0;
//                                                              style = flat;
//                                                              title = "\U65b0\U6d6a\U5fae\U535a";
//                                                              type = webapp;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U7f51\U7edc\U76f4\U64ad";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 140;
//                                                                  forumId = 394;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 0;
//                                                                  listSummaryLength = 0;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 10;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "http://t.qq.com/xuechengfashi";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 61635;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201608/03/fnGUYsq9xgIU.png";
//                                                              iconStyle = circle;
//                                                              id = c53;
//                                                              px = 0;
//                                                              style = flat;
//                                                              title = "\U7f51\U7edc\U76f4\U64ad";
//                                                              type = moduleRef;
//                                                          }
//                                                          );
//                             desc = "";
//                             extParams =             {
//                                 articleId = 0;
//                                 dataId = 0;
//                                 fastpostForumIds =                 (
//                                 );
//                                 filter = "";
//                                 filterId = 0;
//                                 forumId = 0;
//                                 isShowMessagelist = 0;
//                                 isShowTopicTitle = 1;
//                                 listImagePosition = 2;
//                                 listSummaryLength = 40;
//                                 listTitleLength = 40;
//                                 moduleId = 0;
//                                 newsModuleId = 0;
//                                 order = 0;
//                                 orderby = "";
//                                 pageTitle = "";
//                                 redirect = "";
//                                 subDetailViewStyle = flat;
//                                 subListStyle = flat;
//                                 titlePosition = left;
//                                 topicId = 0;
//                             };
//                             icon = "";
//                             iconStyle = image;
//                             id = c54;
//                             px = 0;
//                             style = layoutFourCol;
//                             title = 1470215944925;
//                             type = layout;
//                         },
//                         {
//                             componentList =             (
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U805a\U7126\U9f99\U6cc9";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 502;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = typeid;
//                                                                  filterId = 0;
//                                                                  forumId = 502;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 4;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = all;
//                                                                  redirect = "http://ww2.sinaimg.cn/bmiddle/57492521jw1exzlbstwcfj208c08cglj.jpg";
//                                                                  subDetailViewStyle = flat;
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 0;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201607/28/zjGr6pbhXp0q.png";
//                                                              iconStyle = circle;
//                                                              id = c55;
//                                                              px = 0;
//                                                              style = neteaseNews;
//                                                              title = "\U805a\U7126\U9f99\U6cc9";
//                                                              type = topiclistSimple;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U8d70\U8fd1\U5e08\U7236";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 538;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = typeid;
//                                                                  filterId = 0;
//                                                                  forumId = 538;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = all;
//                                                                  redirect = "http://www.ximalaya.com/zhubo/28998048/";
//                                                                  subDetailViewStyle = flat;
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 0;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201608/03/S4LvjafQbGrA.png";
//                                                              iconStyle = circle;
//                                                              id = c56;
//                                                              px = 0;
//                                                              style = neteaseNews;
//                                                              title = "";
//                                                              type = topiclistSimple;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U548c\U5c1a\U7b54\U7591";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 10;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "http://e.vhall.com/webinar/inituser/415419840";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 61635;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201608/03/hvnfMv8Xqa4L.png";
//                                                              iconStyle = circle;
//                                                              id = c57;
//                                                              px = 0;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = postlist;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "\U94f6\U674f\U6811\U4e0b";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 348;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = typeid;
//                                                                  filterId = 0;
//                                                                  forumId = 348;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = all;
//                                                                  redirect = "http://www.ximalaya.com/zhubo/28998048/";
//                                                                  subDetailViewStyle = flat;
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 0;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201608/03/Ym5idxxTsL3M.png";
//                                                              iconStyle = circle;
//                                                              id = c58;
//                                                              px = 0;
//                                                              style = neteaseNews;
//                                                              title = "";
//                                                              type = topiclistSimple;
//                                                          }
//                                                          );
//                             desc = "";
//                             extParams =             {
//                                 articleId = 0;
//                                 dataId = 0;
//                                 fastpostForumIds =                 (
//                                 );
//                                 filter = "";
//                                 filterId = 0;
//                                 forumId = 0;
//                                 isShowMessagelist = 0;
//                                 isShowTopicTitle = 1;
//                                 listImagePosition = 2;
//                                 listSummaryLength = 40;
//                                 listTitleLength = 40;
//                                 moduleId = 0;
//                                 newsModuleId = 0;
//                                 order = 0;
//                                 orderby = "";
//                                 pageTitle = "";
//                                 redirect = "";
//                                 styleHeader =                 {
//                                     isShow = 1;
//                                     isShowMore = 1;
//                                     position = 0;
//                                     title = "";
//                                 };
//                                 subDetailViewStyle = flat;
//                                 subListStyle = flat;
//                                 titlePosition = left;
//                                 topicId = 0;
//                             };
//                             icon = "";
//                             iconStyle = image;
//                             id = c59;
//                             px = 0;
//                             style = layoutFourCol;
//                             title = 1470220995691;
//                             type = layout;
//                         }
//                         );
//    desc = "";
//    extParams =     {
//        fastpostForumIds =         (
//        );
//        styleHeader =         {
//            isShow = 0;
//            isShowMore = 1;
//            moreComponent =             {
//                componentList =                 (
//                );
//                desc = "";
//                extParams =                 {
//                    articleId = 0;
//                    dataId = 0;
//                    fastpostForumIds =                     (
//                    );
//                    filter = "";
//                    filterId = 0;
//                    forumId = 0;
//                    isShowMessagelist = 0;
//                    isShowTopicTitle = 1;
//                    listBoardNameState = 0;
//                    listImagePosition = 2;
//                    listSummaryLength = 40;
//                    listTitleLength = 40;
//                    moduleId = 1;
//                    newsModuleId = 0;
//                    order = 0;
//                    orderby = "";
//                    redirect = "";
//                    subDetailViewStyle = flat;
//                    subListStyle = flat;
//                    titlePosition = left;
//                    topicId = 0;
//                };
//                icon = "";
//                iconStyle = image;
//                id = c1838;
//                style = flat;
//                title = "";
//                type = forumlist;
//            };
//            position = 0;
//            title = "";
//        };
//        subDetailViewStyle = "<null>";
//        subListStyle = "<null>";
//    };
//    icon = "";
//    iconStyle = image;
//    id = c60;
//    px = 0;
//    style = layoutDefault;
//    title = "";
//    type = layout;
//},
//{
//    componentList =     (
//                         {
//                             componentList =             (
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 0;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 52635;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201607/26/akQHHhfXcq9W.png";
//                                                              iconStyle = image;
//                                                              id = c61;
//                                                              px = 0;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = postlist;
//                                                          }
//                                                          );
//                             desc = "";
//                             extParams =             {
//                                 articleId = 0;
//                                 dataId = 0;
//                                 fastpostForumIds =                 (
//                                 );
//                                 filter = "";
//                                 filterId = 0;
//                                 forumId = 0;
//                                 isShowMessagelist = 0;
//                                 isShowTopicTitle = 1;
//                                 listImagePosition = 2;
//                                 listSummaryLength = 0;
//                                 listTitleLength = 40;
//                                 moduleId = 0;
//                                 newsModuleId = 0;
//                                 order = 0;
//                                 orderby = "";
//                                 pageTitle = "";
//                                 redirect = "";
//                                 styleHeader =                 {
//                                     isShow = 1;
//                                     isShowMore = 1;
//                                     position = 0;
//                                     title = "";
//                                 };
//                                 subDetailViewStyle = flat;
//                                 subListStyle = flat;
//                                 talkId = 0;
//                                 titlePosition = left;
//                                 topicId = 0;
//                             };
//                             icon = "";
//                             iconStyle = image;
//                             id = c62;
//                             px = 0;
//                             style = "layoutOneCol_Low_Fixed";
//                             title = 1469525077570;
//                             type = layout;
//                         }
//                         );
//    desc = "";
//    extParams =     {
//        fastpostForumIds =         (
//        );
//        styleHeader =         {
//            isShow = 0;
//            isShowMore = 1;
//            moreComponent =             {
//                componentList =                 (
//                );
//                desc = "";
//                extParams =                 {
//                    articleId = 0;
//                    dataId = 0;
//                    fastpostForumIds =                     (
//                    );
//                    filter = "";
//                    filterId = 0;
//                    forumId = 0;
//                    isShowMessagelist = 0;
//                    isShowTopicTitle = 1;
//                    listBoardNameState = 0;
//                    listImagePosition = 2;
//                    listSummaryLength = 0;
//                    listTitleLength = 40;
//                    moduleId = 1;
//                    newsModuleId = 0;
//                    order = 0;
//                    orderby = "";
//                    redirect = "";
//                    subDetailViewStyle = "";
//                    subListStyle = "";
//                    talkId = 0;
//                    titlePosition = left;
//                    topicId = 0;
//                };
//                icon = "";
//                iconStyle = image;
//                id = c269;
//                px = 0;
//                style = flat;
//                title = "";
//                type = empty;
//            };
//            position = 0;
//            title = "";
//        };
//        subDetailViewStyle = "<null>";
//        subListStyle = "<null>";
//    };
//    icon = "";
//    iconStyle = image;
//    id = c63;
//    px = 0;
//    style = layoutDefault;
//    title = "";
//    type = layout;
//},
//{
//    componentList =     (
//                         {
//                             componentList =             (
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 352;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 1;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 0;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 7;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "http://forum.longquanzs.org/plugin.php?id=xj_event:wsq_event_center";
//                                                                  subDetailViewStyle = flat;
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 56671;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201512/16/kwU0VTneILym.jpg";
//                                                              iconStyle = image;
//                                                              id = c64;
//                                                              px = 0;
//                                                              style = neteaseNews;
//                                                              title = "";
//                                                              type = newslist;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 352;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 40;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "http://ww2.sinaimg.cn/bmiddle/57492521jw1exzlbstwcfj208c08cglj.jpg";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 54237;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201512/16/7JIZ6PhYXZAL.jpg";
//                                                              iconStyle = image;
//                                                              id = c65;
//                                                              px = 0;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = postlist;
//                                                          }
//                                                          );
//                             desc = "";
//                             extParams =             {
//                                 articleId = 0;
//                                 dataId = 0;
//                                 fastpostForumIds =                 (
//                                 );
//                                 filter = "";
//                                 filterId = 0;
//                                 forumId = 0;
//                                 isShowMessagelist = 0;
//                                 isShowTopicTitle = 1;
//                                 listImagePosition = 2;
//                                 listSummaryLength = 40;
//                                 listTitleLength = 40;
//                                 moduleId = 0;
//                                 newsModuleId = 0;
//                                 order = 0;
//                                 orderby = "";
//                                 pageTitle = "";
//                                 redirect = "";
//                                 styleHeader =                 {
//                                     isShow = 1;
//                                     isShowMore = 1;
//                                     position = 0;
//                                     title = "";
//                                 };
//                                 subDetailViewStyle = flat;
//                                 subListStyle = flat;
//                                 titlePosition = left;
//                                 topicId = 0;
//                             };
//                             icon = "";
//                             iconStyle = image;
//                             id = c66;
//                             px = 0;
//                             style = "layoutTwoCol_Low";
//                             title = 1469697860830;
//                             type = layout;
//                         }
//                         );
//    desc = "";
//    extParams =     {
//        fastpostForumIds =         (
//        );
//        styleHeader =         {
//            isShow = 0;
//            isShowMore = 1;
//            moreComponent =             {
//                componentList =                 (
//                );
//                desc = "";
//                extParams =                 {
//                    articleId = 0;
//                    dataId = 0;
//                    fastpostForumIds =                     (
//                    );
//                    filter = "";
//                    filterId = 0;
//                    forumId = 0;
//                    isShowMessagelist = 0;
//                    isShowTopicTitle = 1;
//                    listBoardNameState = 0;
//                    listImagePosition = 2;
//                    listSummaryLength = 40;
//                    listTitleLength = 40;
//                    moduleId = 1;
//                    newsModuleId = 0;
//                    order = 0;
//                    orderby = "";
//                    redirect = "";
//                    subDetailViewStyle = flat;
//                    subListStyle = flat;
//                    titlePosition = left;
//                    topicId = 0;
//                };
//                icon = "";
//                iconStyle = image;
//                id = c1202;
//                style = flat;
//                title = "";
//                type = forumlist;
//            };
//            position = 0;
//            title = "";
//        };
//        subDetailViewStyle = "<null>";
//        subListStyle = "<null>";
//    };
//    icon = "";
//    iconStyle = image;
//    id = c67;
//    px = 0;
//    style = layoutLine;
//    title = "";
//    type = layout;
//},
//{
//    componentList =     (
//                         {
//                             componentList =             (
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 0;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 51219;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201606/24/mMF5xhuDUKc5.jpg";
//                                                              iconStyle = image;
//                                                              id = c68;
//                                                              px = 1;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = postlist;
//                                                          },
//                                                          {
//                                                              componentList =                     (
//                                                              );
//                                                              desc = "";
//                                                              extParams =                     {
//                                                                  articleId = 0;
//                                                                  dataId = 0;
//                                                                  fastpostForumIds =                         (
//                                                                  );
//                                                                  filter = "";
//                                                                  filterId = 0;
//                                                                  forumId = 0;
//                                                                  isShowMessagelist = 0;
//                                                                  isShowTopicTitle = 1;
//                                                                  listBoardNameState = 0;
//                                                                  listImagePosition = 2;
//                                                                  listSummaryLength = 0;
//                                                                  listTitleLength = 40;
//                                                                  moduleId = 1;
//                                                                  newsModuleId = 0;
//                                                                  order = 0;
//                                                                  orderby = "";
//                                                                  redirect = "http://v.qq.com/vplus/f732fa6f30888efab87401b4530cff9a/videos";
//                                                                  subDetailViewStyle = "";
//                                                                  subListStyle = "";
//                                                                  talkId = 0;
//                                                                  titlePosition = left;
//                                                                  topicId = 0;
//                                                              };
//                                                              icon = "http://forum.longquanzs.org/data/appbyme/upload/uidiy/201606/24/MpVlIQGvZBi8.jpg";
//                                                              iconStyle = image;
//                                                              id = c69;
//                                                              px = 2;
//                                                              style = flat;
//                                                              title = "";
//                                                              type = webapp;
//                                                          }
//                                                          );
//                             desc = "";
//                             extParams =             {
//                                 articleId = 0;
//                                 dataId = 0;
//                                 fastpostForumIds =                 (
//                                 );
//                                 filter = "";
//                                 filterId = 0;
//                                 forumId = 0;
//                                 isShowMessagelist = 0;
//                                 isShowTopicTitle = 1;
//                                 listImagePosition = 2;
//                                 listSummaryLength = 0;
//                                 listTitleLength = 40;
//                                 moduleId = 0;
//                                 newsModuleId = 0;
//                                 order = 0;
//                                 orderby = "";
//                                 pageTitle = "";
//                                 redirect = "";
//                                 styleHeader =                 {
//                                     isShow = 1;
//                                     isShowMore = 1;
//                                     position = 0;
//                                     title = "";
//                                 };
//                                 subDetailViewStyle = flat;
//                                 subListStyle = flat;
//                                 talkId = 0;
//                                 titlePosition = left;
//                                 topicId = 0;
//                             };
//                             icon = "";
//                             iconStyle = image;
//                             id = c70;
//                             px = 0;
//                             style = "layoutSlider_Low";
//                             title = 1466782197425;
//                             type = layout;
//                         }
//                         );
//    desc = "";
//    extParams =     {
//        fastpostForumIds =         (
//        );
//        styleHeader =         {
//            isShow = 0;
//            isShowMore = 1;
//            moreComponent =             {
//                componentList =                 (
//                );
//                desc = "";
//                extParams =                 {
//                    articleId = 0;
//                    dataId = 0;
//                    fastpostForumIds =                     (
//                    );
//                    filter = "";
//                    filterId = 0;
//                    forumId = 0;
//                    isShowMessagelist = 0;
//                    isShowTopicTitle = 1;
//                    listBoardNameState = 0;
//                    listImagePosition = 2;
//                    listSummaryLength = 40;
//                    listTitleLength = 40;
//                    moduleId = 1;
//                    newsModuleId = 0;
//                    order = 0;
//                    orderby = "";
//                    redirect = "";
//                    subDetailViewStyle = flat;
//                    subListStyle = flat;
//                    titlePosition = left;
//                    topicId = 0;
//                };
//                icon = "";
//                iconStyle = image;
//                id = c333;
//                style = flat;
//                title = "";
//                type = forumlist;
//            };
//            position = 0;
//            title = "";
//        };
//        subDetailViewStyle = "<null>";
//        subListStyle = "<null>";
//    };
//    icon = "";
//    iconStyle = image;
//    id = c71;
//    px = 0;
//    style = layoutDefault;
//    title = "";
//    type = layout;
//},
//{
//    componentList =     (
//{
// componentList =             (
//          {
//    componentList =                     (
//              );
//              desc = "\U3010\U7f51\U53cb\U63d0\U95ee\U3011\U8bf7\U95ee\U5e08\U7236\Uff0c\U4f5b\U9640\U6d3b\U7740\U7684\U65f6\U5019\U662f\U5426\U53ea\U662f\U4e00\U4e2a\U666e\U901a\U7684\U5f88";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 0;
//                  hits = 0;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470879399000;
//                  location = "";
//                  "pic_path" = "http://forum.longquanzs.org/data/attachment/forum/201608/11/093631cddo6hqz91bj6vqq.jpg.thumb.jpg";
//                  ratio = "0.716796875";
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 0;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62927";
//                  "source_id" = 62927;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U3010\U7f51\U53cb\U63d0\U95ee\U3011\U8bf7\U95ee\U5e08\U7236\Uff0c\U4f5b\U9640\U6d3b\U7740\U7684\U65f6\U5019\U662f\U5426\U53ea\U662f\U4e00\U4e2a\U666e\U901a\U7684\U5f88";
//                  title = "\U5e08\U7236\U65b0\U6d6a\U5fae\U535a\U95ee\U7b54\Uff082016.8.11\Uff09";
//                  topicId = 62927;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=140882&size=middle";
//                  "user_id" = 140882;
//                  "user_nick_name" = qtrx;
//                  verify =                         (
//                  );
//              };
//              icon = "http://forum.longquanzs.org/data/attachment/forum/201608/11/093631cddo6hqz91bj6vqq.jpg.thumb.jpg";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U5e08\U7236\U65b0\U6d6a\U5fae\U535a\U95ee\U7b54\Uff082016.8.11\Uff09";
//              type = postlist;
//          },
//          {
//              componentList =                     (
//              );
//              desc = "\U6b64\U4e3a\U5b66\U8bda\U6cd5\U5e08\U5fae\U535a\U7b54\U95ee\U5408\U96c6\Uff0c\U5185\U5bb9\U6d89\U53ca\U5bb6\U5ead\U751f\U6d3b\U3001\U5de5\U4f5c\U5b66\U4e60\U3001\U4e3a";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 2;
//                  hits = 0;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470870862000;
//                  location = "";
//                  "pic_path" = "http://forum.longquanzs.org/data/attachment/forum/201607/02/213914zmsynxqbyoyq50yn.jpg.thumb.jpg";
//                  ratio = "1.4785992217899";
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 0;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62913";
//                  "source_id" = 62913;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U6b64\U4e3a\U5b66\U8bda\U6cd5\U5e08\U5fae\U535a\U7b54\U95ee\U5408\U96c6\Uff0c\U5185\U5bb9\U6d89\U53ca\U5bb6\U5ead\U751f\U6d3b\U3001\U5de5\U4f5c\U5b66\U4e60\U3001\U4e3a";
//                  title = "\U4fee\U884c\U7684\U76ee\U7684\U662f\U4ec0\U4e48\U2014\U2014\U5b66\U8bda\U5927\U548c\U5c1a\U5fae\U535a\U7b54\U95ee\U5408\U96c6\U4e4b\U4f5b\U5b66\U7bc7";
//                  topicId = 62913;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=207952&size=middle";
//                  "user_id" = 207952;
//                  "user_nick_name" = hai0070;
//                  verify =                         (
//                  );
//              };
//              icon = "http://forum.longquanzs.org/data/attachment/forum/201607/02/213914zmsynxqbyoyq50yn.jpg.thumb.jpg";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U4fee\U884c\U7684\U76ee\U7684\U662f\U4ec0\U4e48\U2014\U2014\U5b66\U8bda\U5927\U548c\U5c1a\U5fae\U535a\U7b54\U95ee\U5408\U96c6\U4e4b\U4f5b\U5b66\U7bc7";
//              type = postlist;
//          },
//          {
//              componentList =                     (
//              );
//              desc = "\U6b64\U4e3a\U5b66\U8bda\U6cd5\U5e08\U5fae\U535a\U7b54\U95ee\U5408\U96c6\Uff0c\U5185\U5bb9\U6d89\U53ca\U5bb6\U5ead\U751f\U6d3b\U3001\U5de5\U4f5c\U5b66\U4e60\U3001\U4e3a";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 2;
//                  hits = 0;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470870489000;
//                  location = "";
//                  "pic_path" = "http://forum.longquanzs.org/data/attachment/forum/201607/02/213914zmsynxqbyoyq50yn.jpg.thumb.jpg";
//                  ratio = "1.4785992217899";
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 0;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62912";
//                  "source_id" = 62912;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U6b64\U4e3a\U5b66\U8bda\U6cd5\U5e08\U5fae\U535a\U7b54\U95ee\U5408\U96c6\Uff0c\U5185\U5bb9\U6d89\U53ca\U5bb6\U5ead\U751f\U6d3b\U3001\U5de5\U4f5c\U5b66\U4e60\U3001\U4e3a";
//                  title = "\U5982\U4f55\U770b\U5f85\U4f5b\U6559\U4e0e\U5176\U4ed6\U5b97\U6559\U7684\U5173\U7cfb\U2014\U5b66\U8bda\U5927\U548c\U5c1a\U7b54\U95ee\U4e4b\U4f5b\U5b66\U7bc7";
//                  topicId = 62912;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=207952&size=middle";
//                  "user_id" = 207952;
//                  "user_nick_name" = hai0070;
//                  verify =                         (
//                  );
//              };
//              icon = "http://forum.longquanzs.org/data/attachment/forum/201607/02/213914zmsynxqbyoyq50yn.jpg.thumb.jpg";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U5982\U4f55\U770b\U5f85\U4f5b\U6559\U4e0e\U5176\U4ed6\U5b97\U6559\U7684\U5173\U7cfb\U2014\U5b66\U8bda\U5927\U548c\U5c1a\U7b54\U95ee\U4e4b\U4f5b\U5b66\U7bc7";
//              type = postlist;
//          },
//          {
//              componentList =                     (
//              );
//              desc = "\U6b64\U4e3a\U5b66\U8bda\U6cd5\U5e08\U5fae\U535a\U7b54\U95ee\U5408\U96c6\Uff0c\U5185\U5bb9\U6d89\U53ca\U5bb6\U5ead\U751f\U6d3b\U3001\U5de5\U4f5c\U5b66\U4e60\U3001\U4e3a";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 2;
//                  hits = 0;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470869666000;
//                  location = "";
//                  "pic_path" = "http://forum.longquanzs.org/data/attachment/forum/201607/02/213914zmsynxqbyoyq50yn.jpg.thumb.jpg";
//                  ratio = "1.4785992217899";
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 0;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62910";
//                  "source_id" = 62910;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U6b64\U4e3a\U5b66\U8bda\U6cd5\U5e08\U5fae\U535a\U7b54\U95ee\U5408\U96c6\Uff0c\U5185\U5bb9\U6d89\U53ca\U5bb6\U5ead\U751f\U6d3b\U3001\U5de5\U4f5c\U5b66\U4e60\U3001\U4e3a";
//                  title = "\U5982\U4f55\U627e\U5230\U4fe1\U4ef0\U2014\U2014\U5b66\U8bda\U5927\U548c\U5c1a\U5fae\U535a\U7b54\U95ee\U5408\U96c6\U4e4b\U4f5b\U5b66\U7bc7";
//                  topicId = 62910;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=207952&size=middle";
//                  "user_id" = 207952;
//                  "user_nick_name" = hai0070;
//                  verify =                         (
//                  );
//              };
//              icon = "http://forum.longquanzs.org/data/attachment/forum/201607/02/213914zmsynxqbyoyq50yn.jpg.thumb.jpg";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U5982\U4f55\U627e\U5230\U4fe1\U4ef0\U2014\U2014\U5b66\U8bda\U5927\U548c\U5c1a\U5fae\U535a\U7b54\U95ee\U5408\U96c6\U4e4b\U4f5b\U5b66\U7bc7";
//              type = postlist;
//          },
//          {
//              componentList =                     (
//              );
//              desc = "\U7f51\U53cb\U95ee\Uff1a\U5b66\U8bda\U6cd5\U5e08\U60a8\U597d\Uff01\U521a\U6478\U4e86\U6478\U5b69\U5b50\Uff0c\U8fd8\U5728\U53d1\U70e7\Uff0c\U5df2\U7ecf\U611f\U5192\U4e00";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 2;
//                  hits = 0;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470863649000;
//                  location = "";
//                  "pic_path" = "";
//                  ratio = 1;
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 0;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62908";
//                  "source_id" = 62908;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U7f51\U53cb\U95ee\Uff1a\U5b66\U8bda\U6cd5\U5e08\U60a8\U597d\Uff01\U521a\U6478\U4e86\U6478\U5b69\U5b50\Uff0c\U8fd8\U5728\U53d1\U70e7\Uff0c\U5df2\U7ecf\U611f\U5192\U4e00";
//                  title = "\U5b66\U8bda\U6cd5\U5e08\U65b0\U6d6a\U5fae\U535a\U7559\U8a0020160601-30\U6c47\U603b\U7f51\U53cb\U95ee\U7248";
//                  topicId = 62908;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=142056&size=middle";
//                  "user_id" = 142056;
//                  "user_nick_name" = "\U848b\U5b89\U5a1c";
//                  verify =                         (
//                  );
//              };
//              icon = "";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U5b66\U8bda\U6cd5\U5e08\U65b0\U6d6a\U5fae\U535a\U7559\U8a0020160601-30\U6c47\U603b\U7f51\U53cb\U95ee\U7248";
//              type = postlist;
//          },
//          {
//              componentList =                     (
//              );
//              desc = "\U5b66\U4f5b\U6c42\U798f\U5bf9\U5417\Uff1f\U6709\U8bf4\U5bf9\Uff0c\U798f\U6167\U517c\U4fee\U624d\U6709\U6210\U5c31\U561b\Uff1b\U6709\U4eba\U8bf4\U4e0d\U5bf9\Uff0c\U6c42";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 0;
//                  hits = 0;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470838329000;
//                  location = "";
//                  "pic_path" = "";
//                  ratio = 1;
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 0;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62885";
//                  "source_id" = 62885;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U5b66\U4f5b\U6c42\U798f\U5bf9\U5417\Uff1f\U6709\U8bf4\U5bf9\Uff0c\U798f\U6167\U517c\U4fee\U624d\U6709\U6210\U5c31\U561b\Uff1b\U6709\U4eba\U8bf4\U4e0d\U5bf9\Uff0c\U6c42";
//                  title = "\U5b66\U4f5b\U6c42\U798f\Uff0c\U5bf9\U5417\Uff1f";
//                  topicId = 62885;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=216327&size=middle";
//                  "user_id" = 216327;
//                  "user_nick_name" = "\U50e7\U4f3d\U5412";
//                  verify =                         (
//                  );
//              };
//              icon = "";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U5b66\U4f5b\U6c42\U798f\Uff0c\U5bf9\U5417\Uff1f";
//              type = postlist;
//          },
//          {
//              componentList =                     (
//              );
//              desc = "\U6cd5\U5e08\Uff1a\U6211\U7684\U5b69\U5b50\U5feb\U4e0a\U9ad8\U4e2d\U4e86\Uff0c\U8fd1\U534a\U5e74\U8d8a\U6765\U8d8a\U542c\U4e0d\U8fdb\U53bb\U6211\U7684\U8bdd\Uff0c\U4e0d";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 0;
//                  hits = 42;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470798791000;
//                  location = "";
//                  "pic_path" = "";
//                  ratio = 1;
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 1;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62823";
//                  "source_id" = 62823;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U6cd5\U5e08\Uff1a\U6211\U7684\U5b69\U5b50\U5feb\U4e0a\U9ad8\U4e2d\U4e86\Uff0c\U8fd1\U534a\U5e74\U8d8a\U6765\U8d8a\U542c\U4e0d\U8fdb\U53bb\U6211\U7684\U8bdd\Uff0c\U4e0d";
//                  title = "\U5173\U4e8e\U5b69\U5b50\U6559\U80b2";
//                  topicId = 62823;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=216302&size=middle";
//                  "user_id" = 216302;
//                  "user_nick_name" = "\U65e0\U6302\U788d";
//                  verify =                         (
//                  );
//              };
//              icon = "";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U5173\U4e8e\U5b69\U5b50\U6559\U80b2";
//              type = postlist;
//          },
//          {
//              componentList =                     (
//              );
//              desc = "\U5e08\U7236\U7684\U4e94\U5927\U613f\U671b  \U5c06\U4e2d\U56fd\U4f5b\U6559\U7684\U57fa\U672c\U6559\U4e49\U4e0e\U73b0\U4ee3\U6587\U660e\Uff0c\U5c24\U5176\U662f";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 0;
//                  hits = 508;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470789358000;
//                  location = "";
//                  "pic_path" = "http://forum.longquanzs.org/data/attachment/forum/201608/10/084913elx30x3x113ax11h.jpg.thumb.jpg";
//                  ratio = "0.66545454545455";
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 12;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62809";
//                  "source_id" = 62809;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U5e08\U7236\U7684\U4e94\U5927\U613f\U671b  \U5c06\U4e2d\U56fd\U4f5b\U6559\U7684\U57fa\U672c\U6559\U4e49\U4e0e\U73b0\U4ee3\U6587\U660e\Uff0c\U5c24\U5176\U662f";
//                  title = "\U5e08\U7236\U7684\U4e94\U5927\U613f\U671b";
//                  topicId = 62809;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=186873&size=middle";
//                  "user_id" = 186873;
//                  "user_nick_name" = "\U795d\U7edb\U598d";
//                  verify =                         (
//                  );
//              };
//              icon = "http://forum.longquanzs.org/data/attachment/forum/201608/10/084913elx30x3x113ax11h.jpg.thumb.jpg";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U5e08\U7236\U7684\U4e94\U5927\U613f\U671b";
//              type = postlist;
//          },
//          {
//              componentList =                     (
//              );
//              desc = "\U3010\U7f51\U53cb\U63d0\U95ee\U3011\U6cd5\U5e08\U4f60\U597d\Uff0c\U6df1\U591c\U53e8\U6270\U5e0c\U671b\U660e\U65e9\U53ef\U4ee5\U5f97\U5230\U60a8\U7684\U56de\U590d\U3002";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 0;
//                  hits = 303;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470788432000;
//                  location = "";
//                  "pic_path" = "http://forum.longquanzs.org/data/attachment/forum/201608/10/082028qseba6ezsbou5xea.jpg.thumb.jpg";
//                  ratio = "0.716796875";
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 0;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62808";
//                  "source_id" = 62808;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U3010\U7f51\U53cb\U63d0\U95ee\U3011\U6cd5\U5e08\U4f60\U597d\Uff0c\U6df1\U591c\U53e8\U6270\U5e0c\U671b\U660e\U65e9\U53ef\U4ee5\U5f97\U5230\U60a8\U7684\U56de\U590d\U3002";
//                  title = "\U5e08\U7236\U65b0\U6d6a\U5fae\U535a\U95ee\U7b54\Uff082016.8.10\Uff09";
//                  topicId = 62808;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=140882&size=middle";
//                  "user_id" = 140882;
//                  "user_nick_name" = qtrx;
//                  verify =                         (
//                  );
//              };
//              icon = "http://forum.longquanzs.org/data/attachment/forum/201608/10/082028qseba6ezsbou5xea.jpg.thumb.jpg";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U5e08\U7236\U65b0\U6d6a\U5fae\U535a\U95ee\U7b54\Uff082016.8.10\Uff09";
//              type = postlist;
//          },
//          {
//              componentList =                     (
//              );
//              desc = "\U6b64\U4e3a\U5b66\U8bda\U6cd5\U5e08\U5fae\U535a\U7b54\U95ee\U5408\U96c6\Uff0c\U5185\U5bb9\U6d89\U53ca\U5bb6\U5ead\U751f\U6d3b\U3001\U5de5\U4f5c\U5b66\U4e60\U3001\U4e3a";
//              extParams =                     {
//                  "board_id" = 394;
//                  "board_name" = "\U5b66\U4f5b\U95ee\U7b54";
//                  distance = "";
//                  fid = 394;
//                  gender = 2;
//                  hits = 25;
//                  imageList =                         (
//                  );
//                  isHasRecommendAdd = 0;
//                  "last_reply_date" = 1470778744000;
//                  location = "";
//                  "pic_path" = "http://forum.longquanzs.org/data/attachment/forum/201607/02/213914zmsynxqbyoyq50yn.jpg.thumb.jpg";
//                  ratio = "1.4785992217899";
//                  recommendAdd = 0;
//                  redirectUrl = "";
//                  replies = 1;
//                  sourceWebUrl = "http://forum.longquanzs.org/forum.php?mod=viewthread&tid=62805";
//                  "source_id" = 62805;
//                  "source_type" = topic;
//                  special = 0;
//                  summary = "\U6b64\U4e3a\U5b66\U8bda\U6cd5\U5e08\U5fae\U535a\U7b54\U95ee\U5408\U96c6\Uff0c\U5185\U5bb9\U6d89\U53ca\U5bb6\U5ead\U751f\U6d3b\U3001\U5de5\U4f5c\U5b66\U4e60\U3001\U4e3a";
//                  title = "\U65e0\U9650\U751f\U547d\Uff1a\U8f6e\U56de\U2014\U2014\U5b66\U8bda\U5927\U548c\U5c1a\U5fae\U535a\U7b54\U95ee\U5408\U96c6\U4e4b\U4f5b\U5b66\U7bc7";
//                  topicId = 62805;
//                  userAvatar = "http://forum.longquanzs.org/uc_server/avatar.php?uid=207952&size=middle";
//                  "user_id" = 207952;
//                  "user_nick_name" = hai0070;
//                  verify =                         (
//                  );
//              };
//              icon = "http://forum.longquanzs.org/data/attachment/forum/201607/02/213914zmsynxqbyoyq50yn.jpg.thumb.jpg";
//              iconStyle = image;
//              id = "";
//              px = 0;
//              style = flat;
//              title = "\U65e0\U9650\U751f\U547d\Uff1a\U8f6e\U56de\U2014\U2014\U5b66\U8bda\U5927\U548c\U5c1a\U5fae\U535a\U7b54\U95ee\U5408\U96c6\U4e4b\U4f5b\U5b66\U7bc7";
//              type = postlist;
//          }
//          );
//         desc = "";
//         extParams =             {
//             articleId = 0;
//             dataId = 0;
//             fastpostForumIds =                 (
//             );
//             filter = "";
//             filterId = 0;
//             forumId = 0;
//             isShowMessagelist = 0;
//             isShowTopicTitle = 1;
//             listImagePosition = 2;
//             listSummaryLength = 40;
//             listTitleLength = 40;
//             moduleId = 0;
//             newsModuleId = 0;
//             order = 0;
//             orderby = "";
//             pageTitle = "";
//             redirect = "";
//             subDetailViewStyle = flat;
//             subListStyle = flat;
//             titlePosition = left;
//             topicId = 0;
//         };
//         icon = "";
//         iconStyle = image;
//         id = c73;
//         px = 0;
//         style = layoutNewsAuto;
//         title = 1469697514883;
//         type = layout;
//     }
//                         );
//    desc = "";
//    extParams =     {
//        fastpostForumIds =         (
//        );
//        styleHeader =         {
//            isShow = 1;
//            isShowMore = 1;
//            moreComponent =             {
//                componentList =                 (
//                );
//                desc = "";
//                extParams =                 {
//                    articleId = 0;
//                    dataId = 0;
//                    fastpostForumIds =                     (
//                    );
//                    filter = "";
//                    filterId = 0;
//                    forumId = 0;
//                    isShowMessagelist = 0;
//                    isShowTopicTitle = 1;
//                    listBoardNameState = 1;
//                    listImagePosition = 2;
//                    listSummaryLength = 0;
//                    listTitleLength = 40;
//                    moduleId = 1;
//                    newsModuleId = 5;
//                    order = 0;
//                    orderby = "";
//                    redirect = "";
//                    subDetailViewStyle = flat;
//                    subListStyle = "";
//                    talkId = 0;
//                    titlePosition = left;
//                    topicId = 0;
//                };
//                icon = "";
//                iconStyle = image;
//                id = c737;
//                px = 0;
//                style = neteaseNews;
//                title = "";
//                type = newslist;
//            };
//            position = 1;
//            title = "\U5e08\U7236\U6cd5\U8bed\U5f00\U793a";
//        };
//        subDetailViewStyle = "<null>";
//        subListStyle = "<null>";
//    };
//    icon = "";
//    iconStyle = image;
//    id = c74;
//    px = 0;
//    style = layoutDefault;
//    title = "";
//    type = layout;
//}
//)


@end
