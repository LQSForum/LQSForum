//
//  LQSHomePagePersonalMessageViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSHomePagePersonalMessageViewController.h"
#define StretchHeaderHeight 200
@interface LQSHomePagePersonalMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_blueView;
    CGFloat _btnW;
    UIView *_selectView;
    BOOL _isfabiao;
}
@property (nonatomic,assign)NSUInteger page;
@property (nonatomic,strong)LQSHomePagePersonalMessageView *stretchHeaderView;
@property (nonatomic,strong)LQSUITableView *tableView;
@property (nonatomic,strong)NSMutableArray *fabiaoArr;
@property (nonatomic,strong)NSMutableArray *fabiaoArray;
@property (nonatomic,strong)NSMutableArray *detailArr;
@property (nonatomic,strong)NSMutableArray *detailArray;


@end

@implementation LQSHomePagePersonalMessageViewController



- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)loadData{
//请求发表数据
    [self requestFabiaoData];
//请求用户资料数据
    [self requestPersonalData];


}

- (void)requestFabiaoData{

    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"user/topiclist";
    paramDic[@"page"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.page];
    paramDic[@"pageSize"] = @"20";
    paramDic[@"accessToken"] = @"274d079f604beba7d6edaa76be052";
    paramDic[@"isImageList"] = @"1";
    paramDic[@"egnVersion"] = @"v2035.2";
    paramDic[@"accessSecret"] = @"db799660500f1cafae3d030c09caa";
    paramDic[@"sdkVersion"] = @"2.4.3.0";
    paramDic[@"apphash"] = @"2d2e362f";
    paramDic[@"uid"] = @"216430";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        if (weakSelf.fabiaoArray.count > 0 && self.page == 1) {
            [weakSelf.fabiaoArr removeAllObjects];
        }else{
            weakSelf.fabiaoArr = [LQSCishanListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        }
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        [_tableView.mj_header endRefreshing];
        kNetworkNotReachedMessage;
    }];



}

- (void)requestPersonalData{
    
    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"user/userinfo";
    paramDic[@"userId"] = @"216430";
    paramDic[@"accessToken"] = @"274d079f604beba7d6edaa76be052";
    paramDic[@"egnVersion"] = @"v2035.2";
    paramDic[@"accessSecret"] = @"db799660500f1cafae3d030c09caa";
    paramDic[@"sdkVersion"] = @"2.4.3.0";
    paramDic[@"apphash"] = @"2d2e362f";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        if (weakSelf.detailArray.count > 0 && self.page == 1) {
            [weakSelf.detailArr removeAllObjects];
        }else{
            weakSelf.detailArr = [LQSCishanListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        }
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        [_tableView.mj_header endRefreshing];
        kNetworkNotReachedMessage;
    }];



}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
//    创建右边的navItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToEdit)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self tableView];
    
    [self initStretchHeader];
    
}

- (void)jumpToEdit{

    LQSProfileEditViewController *profileEditVc  = [[LQSProfileEditViewController alloc] init];
    [self.navigationController pushViewController:profileEditVc animated:NO];


}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self loadData];


}

- (void)initData{
    _fabiaoArr = [NSMutableArray array];
    _fabiaoArray = [NSMutableArray array];
    _detailArr = [NSMutableArray array];
    _detailArray = [NSMutableArray array];
}

- (void)initStretchHeader
{
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, StretchHeaderHeight + 40 + 40)];
    bgImageView.backgroundColor = [UIColor redColor];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
//    [bgImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"setting_profile_bgWall.jpg"]];///????????接口获得背景图片
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    contentView.backgroundColor = [UIColor purpleColor];
//    contentView.backgroundColor = [UIColor clearColor];
    
    
     UIImageView *avater = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    [avater sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"setting_profile_bgWall.jpg"]];///????????接口获得背景图片
     avater.center = contentView.center;
    avater.layer.cornerRadius = 35;
    avater.clipsToBounds = YES;
     [contentView addSubview:avater];
//    创建可选按钮
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImageView.frame) - 40, kScreenWidth, 40)];
    _selectView.backgroundColor = [UIColor blueColor];
    [contentView addSubview:_selectView];
    
//    创建按钮
    NSString *firstName = [NSString stringWithFormat:@"发表（%@）",nil];//????????接口获得发表数量
    NSArray *arrar = [NSArray arrayWithObjects:firstName,@"资料", nil];
    _btnW = kScreenWidth * 0.5;
    for (NSUInteger i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i *_btnW, 0, _btnW, 40)];
        [button setTitle:[arrar objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitle:[arrar objectAtIndex:i] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.backgroundColor = [UIColor greenColor];
        button.tag = i;
//        添加点击事件
        [button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_selectView addSubview:button];
    }
//    初始化底部的蓝线
    _blueView = [[UIView alloc] initWithFrame:CGRectMake(_btnW * 0.25, _selectView.height - 1, _btnW * 0.5, 1)];
    _blueView.backgroundColor = [UIColor blueColor];
    [_selectView addSubview:_blueView];
    self.stretchHeaderView = [LQSHomePagePersonalMessageView new];
    [self.stretchHeaderView stretchHeaderForTableView:_tableView withView:bgImageView subViews:contentView];
    
}

- (void)touchDown:(UIButton *)sender
{
    if (sender.tag == 0) {
        _isfabiao = YES;
        [UIView animateWithDuration:0.6 animations:^{
            
            _blueView.frame = CGRectMake(_btnW * 0.25, _selectView.height - 1, _btnW * 0.5, 1);

            
        } completion:^(BOOL finished) {
            
            if (finished) {
                //点击发表按钮加载发表控件
                [self requestFabiaoData];
            }
        }];
    }else{
        _isfabiao = NO;
        [UIView animateWithDuration:0.6 animations:^{
            _blueView.frame = CGRectMake(_btnW * 1.25, _selectView.height - 1, _btnW * 0.5, 1);
            
        } completion:^(BOOL finished) {
            
            if (finished) {
//                加载资料控件数据
                [self requestPersonalData];
            }
            
        }];
    }
}


#pragma mark - table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isfabiao == YES) {
        static NSString *identifierCellId = @"fabiaoReuseCell";
        LQSHomePagePersonalPresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCellId ];
        if (!cell) {
            cell = [[LQSHomePagePersonalPresentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCellId];
        }
        [cell pushesDongmanDataModel:[_fabiaoArray objectAtIndex:indexPath.row]];
        
        return cell;

    }else{
    static NSString *identifierDetailCellId = @"personZiliaoCell";
        UITableViewCell *cellZiliao = [tableView dequeueReusableCellWithIdentifier:identifierDetailCellId];
        if (cellZiliao == nil) {
            cellZiliao = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierDetailCellId];
        }
    
    
        return cellZiliao;
    
    }
    
    
}

#pragma mark - stretchableTable delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
}

- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
}

@end