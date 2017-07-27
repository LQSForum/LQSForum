//
//  LQSUIManager.m
//  myOrgForum
//
//  Created by wangbo on 2017/6/25.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSUIManager.h"

@implementation LQSUIManager

+ (LQSUIManager *)sharedManager; {
    static LQSUIManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[LQSUIManager alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self requestInitUIData];
    }
    
    return self;
}

- (void)requestInitUIData {
    //TODO：网址和公共参数提到baseRequest中
    NSString *baseStr = @"http://lqs.zphoo.com/mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"app/initui";
    paramDic[@"isImageList"] = @"1";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    
    paramDic[@"apphash"] = @"5d7f7891";
    paramDic[@"accessToken"] = @"83e1f2e3b07cc0629ac89ed355920";
    paramDic[@"accessSecret"] = @"a742cf58f0d3c28e164f9d9661b6f";
    
    NSMutableDictionary *sortsDic = [NSMutableDictionary dictionary];
    sortsDic[@"type"] = @"0";
    //    paramDic[@"sorts"] = sortsDic;
    //    [paramDic setObject:sortsDic forKey:@"sorts"];
    paramDic[@"sortid"] = @"0";
    paramDic[@"orderby"] = @"marrow";
    paramDic[@"boardId"] = @"0";
    paramDic[@"topOrder"] = @"1";
    paramDic[@"egnVersion"] = @"v2091.5";
    paramDic[@"circle"] = @"0";
    paramDic[@"sdkVersion"] = @"2.5.0.0";
    //    paramDic[@"apphash"] = @"0b8cb156";
    //    paramDic[@"apphash"] = @"826f2657";
    paramDic[@"pageSize"] = @"20";
    
    //    paramDic[@"longitude"] = @"116.300859";
    //    paramDic[@"moduleId"] = @"2";
    //    paramDic[@"latitude"] = @"39.981122";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"tuijian--------sucess");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
 
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"tuijian---------failure");
    
        kNetworkNotReachedMessage;
    }];
}

- (void)

@end
