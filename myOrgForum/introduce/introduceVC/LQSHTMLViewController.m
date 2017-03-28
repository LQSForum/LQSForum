//
//  LQSHTMLViewController.m
//  myOrgForum
//
//  Created by a on 2016/11/1.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSHTMLViewController.h"
#import <WebKit/WebKit.h>
// 下拉菜单
#import "YBPopupMenu.h"
#define TITLES @[@"复制链接", @"浏览器打开", @"分享",@"刷新"]
@interface LQSHTMLViewController ()<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate,UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
@property (nonatomic, strong) UITableView *videoView;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *videoData;
@property (nonatomic, strong) NSMutableArray *redirectData;
@property (nonatomic,strong)UIButton *rightItemBtn;
@property (nonatomic,strong)NSURL *urlToPaste;// 用来复制的URL
@property (nonatomic,strong)WKWebView *webView;

@end

@implementation LQSHTMLViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 如果是打赏页的话，需要改变右上角的按钮功能，改成在浏览器打开等操作。
    if ([self.title isEqualToString:@"打赏"]) {
        [self changeRightNaviItem];
    }else if ([self.title isEqualToString:@"全部打赏"]){
        [self removeRightNaviItem];
        
    }
}

// 如果是全部打赏页，则移除右上角的按钮
- (void)removeRightNaviItem{
    self.navigationItem.rightBarButtonItem = nil;
}
- (void)changeRightNaviItem{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(popupListAct) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];

}
- (void)popupListAct{
    NSLog(@"切换右上角");
    // 弹出下拉菜单
    [YBPopupMenu showAtPoint:CGPointMake(kScreenWidth - 30, 64) titles:TITLES icons:nil menuWidth:120 delegate:self];
}
//html
- (void)loadHtmlControllerWithUrl:(NSURL *)url{
    self.urlToPaste = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    WKWebView *web = [[WKWebView alloc] initWithFrame:self.view.bounds];
    web.UIDelegate = self;
    self.webView = web;
    web.navigationDelegate = self;
    web.opaque = NO;
    web.backgroundColor = [UIColor whiteColor];
    [web loadRequest:request];
    [self.view addSubview:web];
    
}

//网络直播页面
- (void)loadVideoView{
    self.videoView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LQSScreenW, LQSScreenH) style:UITableViewStylePlain];
    self.videoView.delegate = self;
    self.videoView.dataSource = self;
//    self.videoView.backgroundColor = [UIColor greenColor];
    self.videoView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.videoView];
    NSString *urlStringFocus = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=app/moduleconfig";
    NSDictionary *parametersFocus = @{@"accessSecret":@"f24c29a8120733daf65db8635f049",
                                      @"accessToken":@"9681504c5bd171bdc02c2f66a4dee",
                                      @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                      @"sdkVersion":@"2.4.3.0",
                                      @"egnVersion":@"v2035.2",
                                      @"apphash":@"c4fe54dd",
                                      @"configId":@"0",
                                      @"moduleId":@"10"};
    [self loadFocusDataWithUrlString:urlStringFocus parameters:parametersFocus];

}


- (void)loadFocusDataWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters{
    
    [self.sessionManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.videoData removeAllObjects];
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
//      LQSLog(@"%@",dict);
        
        NSArray *dataArr = dict[@"body"][@"module"][@"componentList"];
        for (NSDictionary *itemDict1 in dataArr) {
            NSArray *arr1 = itemDict1[@"componentList"];
            for (NSDictionary *itemDict2 in arr1) {
                NSArray *arr2 = itemDict2[@"componentList"];
                NSString *icon = arr2[0][@"icon"];
                NSString *redirect = arr2[0][@"extParams"][@"redirect"];
                [self.redirectData addObject:redirect];
                [self.videoData addObject:icon];

            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.videoView  reloadData];
            
        });
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [self.mj_header endRefreshing];
        NSLog(@"error%@",error);
        
    }];
    
    
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    NSString *selectedStr =TITLES[index];
    NSLog(@"点击了 %@ 选项",selectedStr);
    if (index == 0) {
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        [pasteBoard setURL:self.urlToPaste];
        if (!pasteBoard) {
            [kAppDelegate showHUDMessage:@"复制失败" hideDelay:1.0];
        }else{
        [kAppDelegate showHUDMessage:@"成功复制到剪切板" hideDelay:1.0];
        }
    }else if(index == 1){
     BOOL openResult = [[UIApplication sharedApplication] openURL:self.urlToPaste];
        if (!openResult) {
            [kAppDelegate showHUDMessage:@"打开链接失败" hideDelay:1.0];
        }
    }else if(index == 2){
        // 分享功能等待集成进来
    }else if(index == 3){
        [self.webView reload];
    }
//    [UIPasteboard generalPasteboard]
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"LQSPartTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.clipsToBounds = YES;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(self.videoData[indexPath.row])] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                iconView.image = image;
            }];
    [cell.contentView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left);
        make.right.equalTo(cell.contentView.mas_right);
        make.top.equalTo(cell.contentView.mas_top).offset(5);
        make.bottom.equalTo(cell.contentView.mas_bottom).offset(-5);
    }];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSURL *url = [NSURL URLWithString:self.redirectData[indexPath.row]];
    LQSHTMLViewController *htmlVc = [[LQSHTMLViewController alloc]init];
    [htmlVc loadHtmlControllerWithUrl:url];
    [self.navigationController pushViewController:htmlVc animated:YES];

}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [kAppDelegate showIndicatorWithMessage:@"loading" hudMode:MBProgressHUDModeIndeterminate];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [kAppDelegate removeHUDDelay:0.0];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [kAppDelegate showHUDMessage:@"网络连接失败，请刷新重试" hideDelay:1.0];
}
#pragma mark - getter方法
- (NSMutableArray *)videoData{
    if (_videoData == nil) {
        _videoData = [NSMutableArray array];
    }
    return _videoData;
}

- (NSMutableArray *)redirectData{
    if (_redirectData == nil) {
        _redirectData = [NSMutableArray array];
    }
    return _redirectData;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSSet *set = [NSSet setWithObjects:@"text/plain", @"text/html", nil];
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
    }
    return _sessionManager;
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

/*
 
 {
	iconStyle = image;
	style = layoutOneCol_Low;
	componentList = (
	{
	desc = ;
	style = flat;
	componentList = (
 );
	id = c82;
	px = 0;
	title = ;
	extParams = {
	listSummaryLength = 40;
	titlePosition = left;
	isShowTopicTitle = 1;
	isShowMessagelist = 0;
	filterId = 0;
	forumId = 0;
	topicId = 0;
	filter = ;
	orderby = ;
	subDetailViewStyle = ;
	listBoardNameState = 0;
	listTitleLength = 40;
	redirect = http://e.vhall.com/webinar/inituser/415419840;
	newsModuleId = 0;
	subListStyle = ;
	articleId = 0;
	dataId = 0;
	fastpostForumIds = (
 );
	listImagePosition = 2;
	moduleId = 1;
	order = 0;
 }
 ;
	type = webapp;
	icon = http://forum.longquanzs.org/data/appbyme/upload/uidiy/201604/02/KM2yD7fP0OCp.jpg;
	iconStyle = image;
 }
 ,
 );
	id = c83;
	px = 0;
	title = 1459640692041;
	extParams = {
	pageTitle = ;
	listSummaryLength = 40;
	styleHeader = {
	isShowMore = 1;
	title = ;
	isShow = 1;
	position = 0;
 }
 ;
	titlePosition = left;
	isShowTopicTitle = 1;
	isShowMessagelist = 0;
	filter = ;
	forumId = 0;
	topicId = 0;
	filterId = 0;
	orderby = ;
	subDetailViewStyle = flat;
	listTitleLength = 40;
	redirect = ;
	newsModuleId = 0;
	subListStyle = flat;
	articleId = 0;
	dataId = 0;
	fastpostForumIds = (
 );
	listImagePosition = 2;
	moduleId = 0;
	order = 0;
 }
 ;
	type = layout;
	desc = ;
	icon = ;
 }
 ,
	{
	iconStyle = image;
	style = layoutOneCol_Low;
	componentList = (
	{
	desc = ;
	style = flat;
	componentList = (
 );
	id = c84;
	px = 0;
	title = 讲师乙班;
	extParams = {
	listSummaryLength = 40;
	titlePosition = left;
	isShowTopicTitle = 1;
	isShowMessagelist = 0;
	filterId = 0;
	forumId = 0;
	topicId = 0;
	filter = ;
	orderby = ;
	subDetailViewStyle = ;
	listBoardNameState = 0;
	listTitleLength = 40;
	redirect = http://e.vhall.com/webinar/inituser/430018745;
	newsModuleId = 0;
	subListStyle = ;
	articleId = 0;
	dataId = 0;
	fastpostForumIds = (
 );
	listImagePosition = 2;
	moduleId = 1;
	order = 0;
 }
 ;
	type = webapp;
	icon = http://forum.longquanzs.org/data/appbyme/upload/uidiy/201604/07/7e96v1mN3iKn.jpg;
	iconStyle = image;
 }
 ,
 );
	id = c85;
	px = 0;
	title = 1460041911108;
	extParams = {
	pageTitle = ;
	listSummaryLength = 40;
	titlePosition = left;
	isShowTopicTitle = 1;
	isShowMessagelist = 0;
	filter = ;
	forumId = 0;
	topicId = 0;
	filterId = 0;
	orderby = ;
	subDetailViewStyle = flat;
	listTitleLength = 40;
	redirect = ;
	newsModuleId = 0;
	subListStyle = flat;
	articleId = 0;
	dataId = 0;
	fastpostForumIds = (
 );
	listImagePosition = 2;
	moduleId = 0;
	order = 0;
 }
 ;
	type = layout;
	desc = ;
	icon = ;
 }
 ,
	{
	iconStyle = image;
	style = layoutOneCol_Low;
	componentList = (
	{
	desc = ;
	style = flat;
	componentList = (
 );
	id = c86;
	px = 0;
	title = ;
	extParams = {
	listSummaryLength = 40;
	titlePosition = left;
	isShowTopicTitle = 1;
	isShowMessagelist = 0;
	filterId = 0;
	forumId = 0;
	topicId = 0;
	filter = ;
	orderby = ;
	subDetailViewStyle = ;
	listBoardNameState = 0;
	listTitleLength = 40;
	redirect = http://e.vhall.com/webinar/inituser/182544124;
	newsModuleId = 0;
	subListStyle = ;
	articleId = 0;
	dataId = 0;
	fastpostForumIds = (
 );
	listImagePosition = 2;
	moduleId = 1;
	order = 0;
 }
 ;
	type = webapp;
	icon = http://forum.longquanzs.org/data/appbyme/upload/uidiy/201604/02/KABXgaRYLmjL.jpg;
	iconStyle = image;
 }
 ,
 );
	id = c87;
	px = 0;
	title = 1459609253753;
	extParams = {
	pageTitle = ;
	listSummaryLength = 40;
	titlePosition = left;
	isShowTopicTitle = 1;
	isShowMessagelist = 0;
	filter = ;
	forumId = 0;
	topicId = 0;
	filterId = 0;
	orderby = ;
	subDetailViewStyle = flat;
	listTitleLength = 40;
	redirect = ;
	newsModuleId = 0;
	subListStyle = flat;
	articleId = 0;
	dataId = 0;
	fastpostForumIds = (
 );
	listImagePosition = 2;
	moduleId = 0;
	order = 0;
 }
 ;
	type = layout;
	desc = ;
	icon = ;
 }
 ,
	{
	icon = ;
	style = layoutOneCol_Low;
	iconStyle = image;
	id = c89;
	componentList = (
	{
	desc = ;
	style = flat;
	px = 0;
	id = c88;
	componentList = (
 );
	title = ;
	extParams = {
	listSummaryLength = 40;
	titlePosition = left;
	isShowTopicTitle = 1;
	isShowMessagelist = 0;
	filterId = 0;
	forumId = 0;
	topicId = 0;
	filter = ;
	orderby = ;
	subDetailViewStyle = ;
	listBoardNameState = 0;
	listTitleLength = 40;
	redirect = http://e.vhall.com/webinar/inituser/555045426;
	newsModuleId = 0;
	subListStyle = ;
	articleId = 0;
	dataId = 0;
	fastpostForumIds = (
 );
	listImagePosition = 2;
	moduleId = 1;
	order = 0;
 }
 ;
	type = empty;
	icon = http://forum.longquanzs.org/data/appbyme/upload/uidiy/201605/06/1xblCjAssi4H.jpg;
	iconStyle = image;
 }
 ,
 );
	title = 1463104348094;
	extParams = {
	pageTitle = ;
	listSummaryLength = 40;
	titlePosition = left;
	isShowTopicTitle = 1;
	isShowMessagelist = 0;
	filter = ;
	forumId = 0;
	topicId = 0;
	filterId = 0;
	orderby = ;
	subDetailViewStyle = flat;
	listTitleLength = 40;
	redirect = ;
	newsModuleId = 0;
	subListStyle = flat;
	articleId = 0;
	dataId = 0;
	fastpostForumIds = (
 );
	listImagePosition = 2;
	moduleId = 0;
	order = 0;
 }
 ;
	type = layout;
	px = 0;
	desc = ;
 }
 ,
 )
 */

@end
