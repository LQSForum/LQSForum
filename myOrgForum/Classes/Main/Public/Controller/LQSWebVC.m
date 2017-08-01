//
//  LQSWebVC.m
//  myOrgForum
//
//  Created by lsm on 17/3/27.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSWebVC.h"

@interface LQSWebVC ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView * webView;

@end

@implementation LQSWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Customed Methods
- (void)initMethod
{
    
    //tablebar背景色
    [self.navigationController.navigationBar setBarTintColor:LQSColor(21, 194, 251, 1)];
    [self.tabBarController.tabBar setHidden:YES];
    
    [self addContentView];
    
}

- (void)addContentView
{
    [self.view addSubview:self.webView];
    
    NSString *requestUrl = self.urlString;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]]];
}
- (void)back
{
    if ([_webView canGoBack])
    {
        [_webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark - webview deleagate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.navigationItem.title = @"载入中...";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

#pragma mark - Setters && Getters

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        _webView.scrollView.bounces = NO;
    }
    
    return _webView;
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
