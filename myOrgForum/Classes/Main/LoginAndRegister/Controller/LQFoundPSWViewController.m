//
//  LQFoundPSWViewController.m
//  myOrgForum
//
//  Created by su on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQFoundPSWViewController.h"

@implementation LQFoundPSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"LQFoundPSWViewController viewDidLoad");
    //这个网址不行
    NSString *path = @"http://forum.longquanzs.org/mobcent/app/web/index.php?r=user/getpwd";
    NSURL *url = [NSURL URLWithString:path];
    //这个http://www.baidu.com网址可以加载页面
    
    //    NSString *path = @"http://www.baidu.com";
    //    NSURL *url = [NSURL URLWithString:path];
    self.view.backgroundColor = [UIColor whiteColor];
    foundPSWWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-80)];
    foundPSWWebView.delegate = self;
    
    [self.view addSubview:foundPSWWebView];
    [foundPSWWebView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
}
@end
