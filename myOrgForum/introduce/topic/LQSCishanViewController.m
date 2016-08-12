//
//  LQSVideoViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSCishanViewController.h"

@interface LQSCishanViewController ()

@end

@implementation LQSCishanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self  reloadCishanDateRequest];




}

- (void)reloadCishanDateRequest
{
    
    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"portal/newslist";
    paramDic[@"sdkVersion"] = @"2.4.0";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    paramDic[@"pageSize"] = @"20";
    paramDic[@"longitude"] = @"116.300859";
    paramDic[@"moduleId"] = @"2";
    paramDic[@"latitude"] = @"39.981122";
    paramDic[@"accessToken"] = @"f9514b902a334d6c0b23305abd46d";
    paramDic[@"page"] = @"1";
    paramDic[@"accessSecret"] = @"cd090971f3f83391cd4ddc034638c";
    paramDic[@"circle"] = @"0";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        
    }];
    
}


@end
