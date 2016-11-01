//
//  LQSHTMLViewController.m
//  myOrgForum
//
//  Created by a on 2016/11/1.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSHTMLViewController.h"

@interface LQSHTMLViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *videoView;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *videoData;
@end

@implementation LQSHTMLViewController

- (NSMutableArray *)videoData{
    if (_videoData == nil) {
        _videoData = [NSMutableArray array];
    }
    return _videoData;
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



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadHtmlControllerWithUrl:(NSURL *)url{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    web.delegate = self;
    
    web.opaque = NO;
    
    web.backgroundColor = [UIColor whiteColor];
    
    [web loadRequest:request];
    
    [self.view addSubview:web];
    
}

- (void)loadVideoView{
    self.videoView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LQSScreenW, LQSScreenH) style:UITableViewStylePlain];
    self.videoView.delegate = self;
    self.videoView.dataSource = self;
    self.videoView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.videoView];
    NSString *urlStringFocus = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=app/moduleconfig";
    NSDictionary *parametersFocus = @{@"accessSecret":@"f24c29a8120733daf65db8635f049",
                                      @"accessToken":@"9681504c5bd171bdc02c2f66a4dee",
                                      @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                      @"sdkVersion":@"2.4.3.0",
                                      @"apphash":@"86449b56",
                                      @"configId":@"0",
                                      @"moduleId":@"10"};
    [self loadFocusDataWithUrlString:urlStringFocus parameters:parametersFocus];

}

//请求我的关注的猜你喜欢数据
- (void)loadFocusDataWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters{
    
    [self.sessionManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
                NSString *p = @"/Users/a/Desktop/plist";
                NSString *path = [p stringByAppendingPathComponent:@"video.plist"];
                [dict writeToFile:path atomically:YES];
//        LQSLog(@"%@",dict);
        
        NSArray *dataArr = dict[@"body"][@"module"][@"componentList"];
        NSArray *arr = [dataArr objectAtIndex: 0][@"componentList"];
        NSLog(@"%@",arr);
        for (NSDictionary *itemDict in dataArr) {
            NSString *icon = itemDict[@"icon"];
            
            [self.videoData addObject:icon];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.videoView  reloadData];
            
        });
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [self.mj_header endRefreshing];
        NSLog(@"error%@",error);
        
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"LQSPartTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LQSScreenW, cell.height)];
//        iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.videoData[indexPath.row]]];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(self.videoData[indexPath.row])] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            iconView.image = image;
        }];
        [cell.contentView addSubview:iconView];
    }
    return cell;

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
