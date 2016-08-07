//
//  LQSIntroduceViewController.m
//  myOrgForum
//  功能：首页
//  Created by 徐经纬 on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSIntroduceViewController.h"
#define KTITLEBTNTAGBEGAN 20160716


@interface LQSIntroduceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainList;

@end



@implementation LQSIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mainList.delegate = self;
    self.mainList.dataSource = self;
    [self.view addSubview:self.mainList];
    self.mainList.backgroundColor = [UIColor yellowColor];
    [self postForData];
    
    
}
#pragma mark - postFordata
- (void)postForData
{
    NSString *loginUrlStr = @"http://forum.longquanzs.org/mobcent/app/web/index.php?";
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    session.responseSerializer = [AFJSONResponseSerializer serializer];
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
    params[@"accessSecret"] = @"";
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
//    [session POST:loginUrlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功");
//        
//        NSData *data = responseObject;
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//        
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败");
//    }];

}
#pragma mark - tableview mainlist
- (UITableView *)mainList
{
    if (!_mainList) {
        _mainList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];
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
        return 10;//待改
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    return cell;
}

@end
