//
//  LQSHomePagePersonalMessageViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSHomePagePersonalMessageViewController.h"
#import "LQSUserManager.h"


#define StretchHeaderHeight 200
@interface LQSHomePagePersonalMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_blueView;
    CGFloat _btnW;
    UIView *_selectView;
    BOOL _isfabiao;
    LQSHomePagePersonalZiliaoDataModel * _personalZiliaoModel;
    LQSHomePagePersonalZiliaoDetailDataModel *_detailModel;
    LQSHomePagePersonalZiliaoProfileListDataModel *_profileListModel;
    
    NSMutableArray * _creditsDataArr;
    NSMutableArray * _creditsTitleArr;

    NSMutableArray * _profileDataArr;
    NSMutableArray * _profileTitleArr;


    
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    _isfabiao = YES;
    _fabiaoArr = [NSMutableArray array];
    _fabiaoArray = [NSMutableArray array];
    _detailArr = [NSMutableArray array];
    _detailArray = [NSMutableArray array];
    _profileDataArr = [NSMutableArray array];
    _creditsDataArr = [NSMutableArray array];
    _profileTitleArr = [NSMutableArray array];
    _creditsTitleArr = [NSMutableArray array];

    //请求发表数据
    self.page = 1;
    if (_isfabiao == YES) {
        [self requestFabiaoDataWithPage:self.page];

    }else{
    //请求用户资料数据
    [self requestPersonalData];
    }

//    创建右边的navItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToEdit)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self tableView];
    
    [self initStretchHeader];
    if (_isfabiao == YES) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    
    _tableView.mj_footer.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [_tableView.mj_header beginRefreshing];


}

- (void)loadNewData{
    self.page = 1;
    [self requestFabiaoDataWithPage:self.page];
    [self.fabiaoArray insertObjects:self.fabiaoArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.fabiaoArr.count)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    });
    
}

- (void)loadMoreData{
    if (self.fabiaoArray.count < 20 && self.page == 1) {
        [self.fabiaoArray removeAllObjects];
    }else{
        self.page++;
    }
    [self requestFabiaoDataWithPage:self.page];
    [self.fabiaoArray addObjectsFromArray:self.fabiaoArr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
    });
    
    
    
    
}

- (void)jumpToEdit{
    
    LQSProfileEditViewController *profileEditVc  = [[LQSProfileEditViewController alloc] init];
    [self.navigationController pushViewController:profileEditVc animated:YES];
    
    
}

- (void)requestFabiaoDataWithPage:(NSUInteger)page{
    
    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"user/topiclist";
    paramDic[@"pageSize"] = @"20";
    paramDic[@"uid"] = [LQSUserManager user].uid;;
    paramDic[@"egnVersion"] = @"v2035.2";
    paramDic[@"type"] = @"topic";
    paramDic[@"sdkVersion"] = @"2.4.3.0";
    paramDic[@"apphash"] = @"e41ec35a";
    paramDic[@"isImageList"] = @"1";
    paramDic[@"accessToken"] = @"83e1f2e3b07cc0629ac89ed355920";
    paramDic[@"page"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.page];
    paramDic[@"accessSecret"] = @"a742cf58f0d3c28e164f9d9661b6f";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"sucess----------");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        if (weakSelf.fabiaoArray.count > 0 && self.page == 1) {
            [weakSelf.fabiaoArray removeAllObjects];
            weakSelf.fabiaoArr = [LQSCishanListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            [weakSelf.fabiaoArray addObjectsFromArray:weakSelf.fabiaoArr];

        }else{
            weakSelf.fabiaoArr = [LQSCishanListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];

        
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        kNetworkNotReachedMessage;
    }];
    
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];

    
}

- (void)requestPersonalData{
    
    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"user/userinfo";
    paramDic[@"userId"] = @"216734";
    paramDic[@"egnVersion"] = @"v2035.2";
    paramDic[@"sdkVersion"] = @"2.4.3.0";
    paramDic[@"apphash"] = @"e41ec35a";
    paramDic[@"accessToken"] = @"83e1f2e3b07cc0629ac89ed355920";
    paramDic[@"accessSecret"] = @"a742cf58f0d3c28e164f9d9661b6f";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess**********");
            _personalZiliaoModel = [LQSHomePagePersonalZiliaoDataModel mj_objectWithKeyValues:responseObject];
//
        NSMutableArray *arr = [_personalZiliaoModel.body objectForKey:@"creditList"];
        if (_creditsDataArr != nil) {
            [_creditsDataArr removeAllObjects];
            
        }
        if (_profileTitleArr != nil) {
            [_profileTitleArr removeAllObjects];
            
        }
        if (_creditsTitleArr != nil) {
            [_creditsTitleArr removeAllObjects];
            
        }
        if (_profileDataArr != nil) {
            [_profileDataArr removeAllObjects];
        }

        
        
        
        for (NSDictionary *dict in arr) {//获取第二组个人得分的title和data
            LQSHomePagePersonalZiliaoProfileListDataModel *profileModel = [[LQSHomePagePersonalZiliaoProfileListDataModel alloc] init];
            profileModel.title = [dict objectForKey:@"title"];
            profileModel.data = [dict objectForKey:@"data"];
            profileModel.type = [dict objectForKey:@"extcredits1"];
            
            [_creditsDataArr addObject:profileModel.data];
            [_creditsTitleArr addObject:profileModel.title];
            
            
        }
        NSMutableArray *profileListArrs = [_personalZiliaoModel.body objectForKey:@"profileList"];
        
        for (NSDictionary *dict in profileListArrs) {//获取第一组个人资料的title和data
            LQSHomePagePersonalZiliaoProfileListDataModel *profileModel = [[LQSHomePagePersonalZiliaoProfileListDataModel alloc] init];
            profileModel.title = [dict objectForKey:@"title"];
            profileModel.data = [dict objectForKey:@"data"];
            profileModel.type = [dict objectForKey:@"extcredits1"];
            
            [_profileDataArr addObject:profileModel.data];
            [_profileTitleArr addObject:profileModel.title];
            
        }



        
        
        
        
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        [_tableView.mj_header endRefreshing];
        kNetworkNotReachedMessage;
    }];
    
    
    
}

- (void)initStretchHeader
{
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, StretchHeaderHeight + 40 + 40)];
    bgImageView.backgroundColor = [UIColor redColor];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:_personalZiliaoModel.icon] placeholderImage:[UIImage imageNamed:@"setting_profile_bgWall.jpg"]];///????????接口获得背景图片
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    
    
     UIImageView *avater = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    [avater sd_setImageWithURL:[NSURL URLWithString:_personalZiliaoModel.icon] placeholderImage:[UIImage imageNamed:@"setting_profile_bgWall.jpg"]];///????????接口获得背景图片
     avater.center = contentView.center;
    avater.layer.cornerRadius = 35;
    avater.clipsToBounds = YES;
     [contentView addSubview:avater];
//    创建可选按钮
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImageView.frame) - 40, kScreenWidth, 40)];
    _selectView.backgroundColor = [UIColor whiteColor];
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
//        button.backgroundColor = [UIColor greenColor];
        button.tag = i;
//        添加点击事件
        [button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_selectView addSubview:button];
    }
//    初始化底部的蓝线
    _blueView = [[UIView alloc] initWithFrame:CGRectMake(_btnW * 0.25, _selectView.height - 1, _btnW * 0.5, 1)];
    _blueView.backgroundColor = LQSColor(22, 191, 251, 1);
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
                self.page = 1;
                [self requestFabiaoDataWithPage:self.page];
            }
        }];
    }else{
        _isfabiao = NO;
        [UIView animateWithDuration:0.6 animations:^{
            _blueView.frame = CGRectMake(_btnW * 1.25, _selectView.height - 1, _btnW * 0.5, 1);
            
        } completion:^(BOOL finished) {
            
            if (finished) {
//                加载资料控件数据
                self.page = 1;
                [self requestPersonalData];
            }
            
        }];
    }
}


#pragma mark - table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isfabiao == YES) {
        _tableView.mj_footer.hidden = _fabiaoArr.count == 0 || (self.page == 1 && _fabiaoArr.count < 20);
        return _fabiaoArray.count;
    }else{
        if (section == 0) {
            return _profileDataArr.count;
        }
        return _creditsDataArr.count;

    
    
    
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isfabiao == YES) {
        LQSHomePagePersonalPresentTableViewCell * cell = (LQSHomePagePersonalPresentTableViewCell * )[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }else
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
        if (_fabiaoArray.count > 0) {
            [cell pushesDongmanDataModel:[_fabiaoArray objectAtIndex:indexPath.row]];
        }
        
        return cell;

    }else{
    static NSString *identifierDetailCellId = @"personZiliaoCell";
        UITableViewCell *cellZiliao = [tableView dequeueReusableCellWithIdentifier:identifierDetailCellId];
        if (cellZiliao == nil) {
            cellZiliao = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierDetailCellId];
            if (indexPath.section == 0 && _profileTitleArr.count >0 && _profileDataArr.count > 0) {
                cellZiliao.textLabel.text = [NSString stringWithFormat:@"%@",[_profileTitleArr objectAtIndex:indexPath.row]];
                cellZiliao.detailTextLabel.text = [NSString stringWithFormat:@"%@",[_profileDataArr objectAtIndex:indexPath.row]];
            }else if (indexPath.section == 1 && _creditsDataArr.count >0 && _creditsTitleArr.count > 0){
                cellZiliao.textLabel.text = [NSString stringWithFormat:@"%@",[_creditsTitleArr objectAtIndex:indexPath.row]];
                cellZiliao.detailTextLabel.text = [NSString stringWithFormat:@"%@",[_creditsDataArr objectAtIndex:indexPath.row]];
            
            }
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