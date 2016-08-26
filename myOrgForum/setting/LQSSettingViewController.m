//
//  LQSSettingViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//设置-我的页面

#import "LQSSettingViewController.h"

@interface LQSSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)LQSUITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) LQSSettingTopDataModel *settingTopModel;

@end

@implementation LQSSettingViewController

- (NSMutableArray *)dataSource
{

    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        LQSSettingModel *model0 = [[LQSSettingModel alloc] init];
        model0.iamge = @"setting_myDraft";//
        model0.title = @"我的草稿";//
        
        LQSSettingModel *model1 = [[LQSSettingModel alloc] init];
        model1.iamge = @"setting_myMessage";//
        model1.title = @"我的消息";//

        
        LQSSettingModel *model2 = [[LQSSettingModel alloc] init];
        model2.iamge = @"setting_accountManage";
        model2.title = @"账号管理";
        
        LQSSettingModel *model3 = [[LQSSettingModel alloc] init];
        model3.iamge = @"setting_personalSetting";
        model3.title = @"个人设置";
        [self.dataSource addObject:model0];
        [self.dataSource addObject:model1];

        [self.dataSource addObject:model2];
        [self.dataSource addObject:model3];
    }

    return _dataSource;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//请求用户数据
    [self requestUserData];


}

- (void)createTableView{
    self.tableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];


}

- (void)requestUserData{
    NSString *baseUrl = @"http://forum.longquanzs.org//mobcent/app/web/index.php";

    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"user/userinfo";
    paramDic[@"userId"] = @"216734";/////??????????////需要登陆获取
    
    paramDic[@"egnVersion"] = @"v2035.2";
    paramDic[@"sdkVersion"] = @"2.4.3.0";
    paramDic[@"apphash"] = @"5d7f7891";
    paramDic[@"accessToken"] = @"83e1f2e3b07cc0629ac89ed355920";
    paramDic[@"accessSecret"] = @"a742cf58f0d3c28e164f9d9661b6f";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    __weak typeof(self) weakSelf = self;
    [manager POST:baseUrl parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LQSLog(@"sucess");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        LQSSettingTopDataModel *settingTopModel = [LQSSettingTopDataModel new];
        self.settingTopModel = settingTopModel;
        settingTopModel.userTitle = dict[@"userTitle"];
        settingTopModel.icon = dict[@"icon"];
        settingTopModel.score = dict[@"score"];
        settingTopModel.credits = dict[@"credits"];
        LQSLog(@"...");
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LQSLog(@"failure");

    }];



}




#pragma mark -m tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }else if (section == 1){
        return 40;
    }
        return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView * sectionView  =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40 + 10)];
        sectionView.userInteractionEnabled = YES;
//        创建三个按钮
        CGFloat labelW = kScreenWidth /3;
        CGFloat labelH = 40;
//        第一个btn
        NSArray *nameArr = @[@"我的收藏",@"我的好友",@"我的发表"];
        for (NSUInteger i = 0; i < 3; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * labelW, 0, labelW, labelH)];
            label.tag = i;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [nameArr objectAtIndex:i];
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
            [label addGestureRecognizer:tapGesture];
            [sectionView addSubview:label];
        
        }
        
//        添加高度为10的分割线
        UIView *gapView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 10)];
        gapView.backgroundColor = [UIColor magentaColor];
        gapView.backgroundColor = [UIColor clearColor];
        [sectionView addSubview:gapView];
//        添加分割线
        CGFloat fengeW = 1;
        CGFloat fengeH = 20;
        for (NSUInteger j= 0; j < 2; j++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake((j + 1) * labelW, LQSMargin, fengeW, fengeH)];
            view.userInteractionEnabled = YES;
            view.backgroundColor = [UIColor lightGrayColor];
            
            
            [sectionView addSubview:view];
        }
        
        
        sectionView.backgroundColor = [UIColor blueColor];
        return sectionView;
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.1;
    }
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *topCellIdentifier = @"topCell";
        LQSSettingTopCell *topCell = [tableView dequeueReusableCellWithIdentifier:topCellIdentifier];
        if (topCell == nil) {
            topCell = [[LQSSettingTopCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:topCellIdentifier];
        }
        topCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [topCell pushSettingTopDataModel:self.settingTopModel];
        topCell.backgroundColor = [UIColor purpleColor];
        return topCell;
        
        
    }else{
        NSString *identifier = @"settingCellIdentifier";
        
        LQSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[LQSSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (indexPath.section == 1) {
            [cell pushSettingModel:self.dataSource[indexPath.row]];
        }else if (indexPath.section == 2){
            [cell pushSettingModel:self.dataSource[indexPath.row + 2]];
            
        }
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

#pragma mark -m TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    if (indexPath.section == 1 && indexPath.row == 0) {
      vc =  [[LQSMyDraftViewController alloc] init];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        vc = [[LQSMessageViewController alloc] init];
    }else if (indexPath.section == 2 && indexPath.row == 0){
        vc = [[LQSAccountManagementViewController alloc] init];
    }else{
        vc = [[LQSDetailSettingViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 50;
    }
}

- (void)tapEvent:(UITapGestureRecognizer *)gesture
{
    UIViewController *Vc = [UIViewController new];
    UIView *view = gesture.view;
        if (view.tag == 0) {
            Vc = [LQSSettingMyFavourateViewController new];
        }else if (view.tag == 1){
            Vc = [LQSSettingMyFriendViewController new];
        }else if (view.tag == 2){
            Vc = [LQSSettingMyPresentViewController new];
        }
        [self.navigationController pushViewController:Vc animated:NO];
    }
    
    
    




@end
